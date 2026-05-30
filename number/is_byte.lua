-- Check that given argument is integer in byte range

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

-- Imports:
local get_bits = request('get_bits')

local is_byte =
  function(value)
    if not is_integer(value) then return false end

    return (value == get_bits(value, 0, 7))
  end

-- Export:
return is_byte

--[[
  2020
  2024
  2026-05-30
]]
