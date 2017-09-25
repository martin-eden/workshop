local get_loaded_module_files = request('!.system.get_loaded_module_files')
local strip_lua_postfix = request('strip_lua_postfix')

return
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
