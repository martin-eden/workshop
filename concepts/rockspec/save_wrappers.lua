local get_wrappers = request('get_wrappers')
local save_to_file = request('!.string.save_to_file')

return
  function(cfg)
    assert_table(cfg.commands)
    local wrappers = get_wrappers(cfg)
    for i, rec in ipairs(cfg.commands) do
      save_to_file(rec.wrapper, wrappers[i])
    end
  end
