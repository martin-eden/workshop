-- Check that given argument is integer in 16-bit word range

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

-- Imports:
local get_bits = request('get_bits')

local is_word =
  function(value)
    if not is_integer(value) then return false end

    return (value == get_bits(value, 0, 15))
  end

return is_word

--[[
  2024
  2026-05-30
]]
