-- Bit values characters

--[[
  Author: Martin Eden
  Last mod.: 2026-09-14
]]

--[[
  Written to have common data source for bit codec functions.
]]

local BitToChar_Map = { [false] = '.', [true] = 'X' }

local invert_table = request('!.table.invert')

-- Export:
return
  {
    BitToChar_Map = BitToChar_Map,
    CharToBit_Map = invert_table(BitToChar_Map),
  }

--[[
  2026 #
]]
