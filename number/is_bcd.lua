-- Check that BCD byte is valid

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

-- Imports:
local is_byte = request('!.number.is_byte')
local get_bits = request('get_bits')

local is_valid_bcd =
  function(byte_bcd)
    assert_integer(byte_bcd)

    if not is_byte(byte_bcd) then return false end

    if (get_bits(byte_bcd, 0, 3) > 9) then return false end
    if (get_bits(byte_bcd, 4, 7) > 9) then return false end

    return true
  end

-- Export:
return is_valid_bcd

--[[
  2020
  2026-05-05
  2026-05-30
]]
