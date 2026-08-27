-- Check that string is valid Lua name and is not a keyword

--[[
  Author: Martin Eden
  Last mod.: 2026-08-28
]]

local identifier_pattern = '^[%a_][%w_]*$'

local Keywords_Map
do
  -- Imports:
  local Keywords = request('Keywords')
  local map_values = request('!.table.map_values')

  Keywords_Map = map_values(Keywords)
end

local str_match = string.match

-- Export:
return
  function(str)
    if not is_string(str) then return false end

    return
      str_match(str, identifier_pattern) and
      not Keywords_Map[str]
  end

--[[
  2016
  2026-06-18
]]
