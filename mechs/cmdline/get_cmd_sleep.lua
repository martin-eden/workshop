--[[
  Return shell command to sleep given number of seconds.
  Seconds may be fractional number.

  GNU/bash assumed.
]]

return
  function(secs)
    return ('sleep %.2f'):format(secs)
  end
