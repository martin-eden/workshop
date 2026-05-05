-- Check that BCD byte is valid

--[[
  Author: Martin Eden
  Last mod.: 2026-05-05
]]

-- Imports:
local is_byte = request('!.number.is_byte')

local is_valid_bcd =
  function(byte_bcd)
    assert_integer(byte_bcd)

    if not is_byte(byte_bcd) then return false end
    if (byte_bcd % 16 > 9) then return false end
    if (byte_bcd // 16 > 9) then return false end

    return true
  end

-- Export:
return is_valid_bcd

--[[
  2020
  2026-05-05
]]
