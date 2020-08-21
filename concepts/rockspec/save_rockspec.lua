local get_rockspec = request('get_rockspec')
local save_to_file = request('!.string.save_to_file')

return
  function(cfg)
    save_to_file(cfg.rockspec_name, get_rockspec(cfg))
  end
