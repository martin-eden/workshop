-- Bit values characters

--[[
  Author: Martin Eden
  Last mod.: 2026-05-17
]]

--[[
  Written for bit codec functions to have common data source.
]]

-- Imports:
local invert_table = request('!.table.invert')

local BitToChar_Map =
  {
    [false] = '.',
    [true] = 'X',
  }

local CharToBit_Map = invert_table(BitToChar_Map)

-- Export:
return
  {
    BitToChar_Map = BitToChar_Map,
    CharToBit_Map = CharToBit_Map,
  }

--[[
  2026-05-17
]]
