-- Convert byte in BCD format to byte

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local get_bits = request('!.number.get_bits')

return
  function(byte_bcd)
    return get_bits(byte_bcd, 4, 7) * 10 + get_bits(byte_bcd, 0, 3)
  end

--[[
  2019 # #
  2026 # # #
]]
