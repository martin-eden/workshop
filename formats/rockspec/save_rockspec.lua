local fopen = request('!.file.safe_open')
local get_rockspec = request('get_rockspec')

return
  function(cfg)
    local f = fopen(cfg.rockspec_name, 'w')
    f:write(get_rockspec(cfg))
    f:close()
  end
