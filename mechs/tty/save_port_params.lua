--[[
  Save TTY device parameters as special-format string for later
  restoration.
]]

return
  function(tty_name)
    assert_string(tty_name)
    local cmd = ('stty --file=%s --save'):format(tty_name)
    local f_output = assert(io.popen(cmd))
    local result = f_output:read('l')
    f_output:close()
    return result
  end
