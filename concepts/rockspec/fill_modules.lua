-- Fill rockspec "modules" table: { [module_name] = file_name, ... }

--[[
  Author: Martin Eden
  Last mod.: 2026-08-10
]]

local fill_modules
do
  local get_clean_file_name
  do
    local self_dir
    do
      local Syntels = request('!.concepts.path_name.Syntels')
      self_dir = Syntels.self_dir
    end
    local rebase_to = request('!.concepts.path_name.rebase_to')
    local normalize = request('!.concepts.path_name.normalize')

    get_clean_file_name =
      function(file_name)
        return normalize(rebase_to(self_dir, file_name))
      end
  end

  local get_module_name
  do
    local strip_lua_postfix = request('strip_lua_postfix')
    local pathname_divider
    do
      local Syntels = request('!.concepts.path_name.Syntels')
      pathname_divider = Syntels.separator
    end
    local luaname_divider = '.'
    local str_gsub = string.gsub

    get_module_name =
      function(Config, clean_file_name)
        local result

        result = strip_lua_postfix(clean_file_name)
        result = str_gsub(result, pathname_divider, luaname_divider)
        result = Config.project_name .. luaname_divider .. result

        return result
      end
  end

  fill_modules =
    function(Config)
      local Result = { }

      for _, file_name in ipairs(Config.used_files) do
        local clean_file_name = get_clean_file_name(file_name)
        local module_name = get_module_name(Config, clean_file_name)

        Result[module_name] = clean_file_name
      end

      return Result
    end
end

-- Export:
return fill_modules

--[[
  2017
  2018
  2026-08-10
]]
