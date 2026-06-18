-- Check that string is valid Lua name and is not a keyword

--[[
  Author: Martin Eden
  Last mod.: 2026-06-18
]]

local Keywords_Map
do
  -- Imports:
  local Keywords = request('Keywords')
  local map_values = request('!.table.map_values')

  Keywords_Map = map_values(Keywords)
end

local is_identifier =
  function(str)
    return
      is_string(str) and
      string.match(str, '^[%a_][%w_]*$') and
      not Keywords_Map[str]
  end

-- Export:
return is_identifier

--[[
  2016
  2026-06-18
]]
