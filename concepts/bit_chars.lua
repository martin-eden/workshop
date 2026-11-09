-- Bit values characters

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

-- Common data source for bit codec functions

local bit_to_char_map = { [false] = '.', [true] = 'X' }
local invert_table = request('!.table.invert')

return
  {
    bit_to_char_map = bit_to_char_map,
    char_to_bit_map = invert_table(bit_to_char_map),
  }

--[[
  2026 #
]]
