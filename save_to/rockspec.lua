local fill_template =
  function(template, substitutions)
    local result =
      template:gsub('%$([%w_]+)', substitutions)
    return result
  end

local strip_updirs =
  function(s)
    return s:gsub('%.%./', '')
  end

local strip_self_prefix =
  function(s)
    return s:gsub('^%./', '')
  end

local get_file_name =
  function(file_name)
    return strip_self_prefix(strip_updirs(file_name))
  end

local strip_lua_postfix =
  function(s)
    return s:gsub('%.lua$', '')
  end

local get_module_name =
  function(cfg, file_name)
    local result

    result = file_name
    result = strip_self_prefix(result)
    result = strip_lua_postfix(result)
    result = strip_updirs(result)
    result = result:gsub('/', '.')
    result = cfg.project_name .. '.' .. result

    return result
  end

local fill_modules =
  function(cfg)
    local result = {}
    local files = cfg.used_files
    table.sort(files)
    for i = 1, #files do
      local file_name = get_file_name(files[i])
      local module_name = get_module_name(cfg, file_name)
      result[module_name] = file_name
    end
    return result
  end

local get_loaded_module_files = request('^.handy_mechs.get_loaded_module_files')

local augment_config =
  function(cfg)
    assert_string(cfg.project_name)
    cfg.rockspec_name = ('%s-scm-1.rockspec'):format(cfg.project_name)
    cfg.used_files = cfg.used_files or get_loaded_module_files()
    cfg.bash_script_name = cfg.bash_script_name or ('%s.sh'):format(cfg.bash_command_name)
    cfg.bash_command_name = cfg.bash_command_name or cfg.bash_script_name
    if cfg.lua_main_module then
      cfg.lua_main_module = strip_lua_postfix(cfg.lua_main_module)
    end
  end

local bash_wrapper_template =
[[
#!/bin/bash

in_file=$1
out_file=$2

lua_call="
do
  require('$package.workshop.base')
  local run = request('$package.$lua_main')
  run('$in_file', '$out_file')
end
"

echo $lua_call | lua
]]

local get_bash_wrapper =
  function(cfg)
    local result =
      fill_template(
        bash_wrapper_template,
        {
          package = cfg.project_name,
          lua_main = cfg.lua_main_module,
        }
      )
    return result
  end

local fopen = request('^.file.safe_open')

local save_bash_wrapper =
  function(cfg)
    local f = fopen(cfg.bash_script_name, 'w')
    f:write(get_bash_wrapper(cfg))
    f:close()
  end

local rockspec_template =
[[
package = '$package'
version = 'scm-1'

source = {
  url = '?',
}

description = {
  summary = '?',
  license = '?',
  homepage = '?',
}

dependencies = {
  'lua ~> 5.3',
}

build = {
  type = 'builtin',
  install = {
    bin = $shell_scripts,
  },
  modules = $modules,
}
]]

local table_to_string = request('lua_simple_table')

local get_rockspec =
  function(cfg)
    local modules = fill_modules(cfg)
    local shell_scripts
    if cfg.bash_script_name then
      shell_scripts =
        {
          [cfg.bash_command_name] = cfg.bash_script_name
        }
    end
    local substitutions =
      {
        package = cfg.project_name,
        modules = table_to_string(modules, {initial_deep = 2}),
        shell_scripts = table_to_string(shell_scripts, {initial_deep = 4}),
      }
    local result = fill_template(rockspec_template, substitutions)
    return result
  end

local save_rockspec =
  function(cfg)
    local f = fopen(cfg.rockspec_name, 'w')
    f:write(get_rockspec(cfg))
    f:close()
  end

return
  {
    augment_config = augment_config,
    get_rockspec = get_rockspec,
    save_rockspec = save_rockspec,
    get_bash_wrapper = get_bash_wrapper,
    save_bash_wrapper = save_bash_wrapper,
  }
