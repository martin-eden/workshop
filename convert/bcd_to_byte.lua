-- Convert byte in BCD format to byte

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

-- Imports:
local get_bits = request('!.number.get_bits')

local bcd_to_byte =
  function(byte_bcd)
    return get_bits(byte_bcd, 4, 7) * 10 + get_bits(byte_bcd, 0, 3)
  end

-- Export:
return bcd_to_byte

--[[
  2019 # #
  2026-05-05
  2026-05-13
  2026-05-30
]]
