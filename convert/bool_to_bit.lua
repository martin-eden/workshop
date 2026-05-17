-- Convert boolean to bit

--[[
  Author: Martin Eden
  Last mod.: 2026-05-17
]]

-- Imports:
local BitChars = request('!.concepts.BitChars')

local bit_0_char = BitChars.BitToChar_Map[false]
local bit_1_char = BitChars.BitToChar_Map[true]

local bool_to_bit =
  function(bit_value)
    assert_boolean(bit_value)
    if bit_value then return bit_1_char else return bit_0_char end
  end

-- Export:
return bool_to_bit

--[[
  2026-05-07
]]
