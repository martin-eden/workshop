local get_loaded_module_files = request('!.system.get_loaded_module_files')
local strip_lua_postfix = request('strip_lua_postfix')

return
  function(cfg)
    assert_string(cfg.project_name)
    cfg.rockspec_name = ('%s-scm-1.rockspec'):format(cfg.project_name)
    cfg.used_files = cfg.used_files or get_loaded_module_files()

    if cfg.bash_commands then
      assert_table(cfg.bash_commands)
      for _, rec in ipairs(cfg.bash_commands) do
        assert_string(rec.script)
        assert_string(rec.command)
        assert_string(rec.lua_module)
        rec.lua_module = strip_lua_postfix(rec.lua_module)
      end
    end
  end
