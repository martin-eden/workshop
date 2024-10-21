--[[
  Return shell command to sleep given number of seconds.
  Seconds may be fractional number.

  GNU/bash assumed.
]]

-- Last mod: 2020-01-21

return
  function(secs)
    return ('sleep %.2f'):format(secs)
  end

--[[
  2020-01-21
]]
