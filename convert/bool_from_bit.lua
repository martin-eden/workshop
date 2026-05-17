-- Convert bit to boolean

--[[
  Author: Martin Eden
  Last mod.: 2026-05-17
]]

-- Imports:
local BitChars = request('!.concepts.BitChars')

local bit_0_char = BitChars.BitToChar_Map[false]
local bit_1_char = BitChars.BitToChar_Map[true]

local bool_from_bit =
  function(bit_str)
    if (bit_str == bit_0_char) then return false end
    if (bit_str == bit_1_char) then return true end
    error(string.format('Wrong bit character %q.', bit_str))
  end

-- Export:
return bool_from_bit

--[[
  2026-05-07
]]
