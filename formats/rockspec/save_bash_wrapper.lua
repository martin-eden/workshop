local fopen = request('!.file.safe_open')
local get_bash_wrapper = request('get_bash_wrapper')

return
  function(cfg)
    local f = fopen(cfg.bash_script_name, 'w')
    f:write(get_bash_wrapper(cfg))
    f:close()
  end
