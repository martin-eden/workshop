--[[
  Return string with escaped hex byte for given string with byte.

  So for ' ' it will return '\x20'.

  This function intended for use as gsub() match handler.
]]

return
  function(c)
    return ([[\x%02X]]):format(c:byte(1, 1))
  end
