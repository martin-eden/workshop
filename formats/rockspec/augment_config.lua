local get_loaded_module_files = request('!.system.get_loaded_module_files')
local strip_lua_postfix = request('strip_lua_postfix')
local get_modules_dependencies = request('!.system.get_modules_dependencies')
local get_module_location = request('!.system.get_module_location')

return
  function(cfg)
    assert_string(cfg.project_name)
    assert_string(cfg.short_desc)
    assert_string(cfg.description)
    assert_string(cfg.license)
    assert_table(cfg.repository)
    assert_string(cfg.repository.url)
    assert_string(cfg.repository.branch)

    cfg.rockspec_name = ('%s-scm-1.rockspec'):format(cfg.project_name)

    assert_table(cfg.used_modules)

    if cfg.bash_commands then
      assert_table(cfg.bash_commands)
      for _, rec in ipairs(cfg.bash_commands) do
        assert_string(rec.script)
        assert_string(rec.command)
        assert_string(rec.lua_script)
        rec.lua_script = strip_lua_postfix(rec.lua_script)
      end
    end

    local used_modules = get_modules_dependencies(cfg.used_modules)
    if cfg.bash_commands then
      for _, rec in ipairs(cfg.bash_commands) do
        table.insert(used_modules, rec.lua_script)
      end
    end
    local used_files = {}
    for i = 1, #used_modules do
      used_files[i] = get_module_location(used_modules[i])
    end
    table.sort(used_files)
    cfg.used_files = used_files
  end
