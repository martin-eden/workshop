--[[
  Set TTY device parameters from stty-readable string.

  Stty-readable string usually produced by "$ stty --save".

  Input:

    string - Port name
    string - Encoded port configuration
]]

return
  function(tty_name, params)
    assert_string(tty_name)
    assert_string(params)
    local cmd = ('stty --file=%s %s'):format(tty_name, params)
    -- print(('%q'):format(cmd))

    local isOk, errorMsg, errorCode = os.execute(cmd)

    return errorMsg
  end

--[[
  2020-01
  2021-11
  2023-04
  2024-09
]]
