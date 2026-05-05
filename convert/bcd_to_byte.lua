-- Convert byte in BCD format to byte

--[[
  Author: Martin Eden
  Last mod.: 2026-05-05
]]

-- Imports:
local is_bcd = request('!.number.is_bcd')

local bcd_to_byte =
  function(byte_bcd)
    assert(is_bcd(byte_bcd))

    return (byte_bcd // 16) * 10 + (byte_bcd % 16)
  end

-- Export:
return bcd_to_byte

--[[
  2019 # #
  2026-05-05
]]
