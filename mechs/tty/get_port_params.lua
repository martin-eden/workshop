--[[
  Get TTY device parameters as special-format string for later
  restoration.

  Input:

    string - Port name

  Output:

    string - Encoded port configuration
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

--[[
  2020-01
  2021-11
  2023-04
  2024-09
]]
