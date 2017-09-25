local get_bash_wrappers = request('get_bash_wrappers')
local save_to_file = request('!.string.save_to_file')

return
  function(cfg)
    assert_table(cfg.bash_commands)
    local wrappers = get_bash_wrappers(cfg)
    for i, rec in ipairs(cfg.bash_commands) do
      save_to_file(rec.script, wrappers[i])
    end
  end
