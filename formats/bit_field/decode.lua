--[[
  Represent binary string as string with bits.

  For heavy usage we ought to build lookup table. But currently
  naive implementation preferred.
]]

local bits = {[0] = '0', [1] = '1'}

local byte_to_bit_str =
  function(c)
    local b = c:byte()
    local result = ''
    for i = 1, 8 do
      local bit = bits[b & 1]
      result = bit .. result
      b = b >> 1
    end
    return result
  end

return
  function(s)
    assert_string(s)
    local result
    result = s:gsub('.', byte_to_bit_str)
    return result
  end
