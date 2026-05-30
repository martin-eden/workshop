-- Convert byte to byte in BCD format

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

-- Imports:
local set_bits = request('!.number.set_bits')

local bcd_from_byte =
  function(byte)
    local tens = byte // 10
    local ones = byte % 10

    return set_bits(tens, 4, 7) | set_bits(ones, 0, 3)
  end

-- Export:
return bcd_from_byte

--[[
  2019 # #
  2026-05-05
  2026-05-13
  2026-05-30
]]
