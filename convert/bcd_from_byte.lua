-- Convert byte to byte in BCD format

--[[
  Author: Martin Eden
  Last mod.: 2026-05-05
]]

-- Imports:
local is_bcd_able = request('!.number.is_bcd_able')

local bcd_from_byte =
  function(byte)
    assert(is_bcd_able(byte))

    return ((byte // 10) * 16) + (byte % 10)
  end

-- Export:
return bcd_from_byte

--[[
  2019 # #
  2026-05-05
]]
