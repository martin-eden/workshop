-- Convert boolean to bit

--[[
  Author: Martin Eden
  Last mod.: 2026-05-07
]]

local bit_1_char = 'X'
local bit_0_char = '.'

local bool_to_bit =
  function(bool)
    assert_boolean(bool)
    if bool then return bit_1_char else return bit_0_char end
  end

-- Export:
return bool_to_bit

--[[
  2026-05-07
]]
