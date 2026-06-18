-- Map of Lua keywords

--[[
  Author: Martin Eden
  Last mod.: 2026-06-18
]]

-- Imports:
local map_values = request('!.table.map_values')

local Keywords_Map =
  map_values(
    {
      'nil',
      'true',
      'false',
      'not',
      'and',
      'or',
      'do',
      'end',
      'local',
      'function',
      'goto',
      'if',
      'then',
      'elseif',
      'else',
      'while',
      'repeat',
      'until',
      'for',
      'in',
      'break',
      'return',
    }
  )

-- Export:
return Keywords_Map

--[[
  2016
  2026-06-18
]]
