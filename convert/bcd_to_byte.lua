-- Convert byte in BCD format to byte

--[[
  Author: Martin Eden
  Last mod.: 2026-05-13
]]

local bcd_to_byte =
  function(byte_bcd)
    return (byte_bcd // 16) * 10 + (byte_bcd % 16)
  end

-- Export:
return bcd_to_byte

--[[
  2019 # #
  2026-05-05
  2026-05-13
]]
