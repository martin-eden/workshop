-- Convert bit to boolean

--[[
  Author: Martin Eden
  Last mod.: 2026-05-07
]]

local bit_1_char = 'X'
local bit_0_char = '.'

local bool_from_bit =
  function(str)
    if (str == bit_1_char) then return true end
    if (str == bit_0_char) then return false end
    error('Wrong bit character')
  end

-- Export:
return bool_from_bit

--[[
  2026-05-07
]]
