--[[
  Return true if given data represent BCD byte.
  Else return false and string with error in second result.
]]

local is_byte = request('is_byte')

return
  function(n)
    local result, err_msg = is_byte(n)
    if result then
      local low_digit = n & 0x0F
      local high_digit = (n >> 4) & 0x0F
      if (high_digit > 9) or (low_digit > 9) then
        result = false
        err_msg = ("Number 0x%02X can't be interpreted as BCD."):format(n)
      end
    end
    return result, err_msg
  end
