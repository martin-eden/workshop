-- Check that string is valid Lua name and is not a keyword

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

local identifier_pattern = '^[%a_][%w_]*$'

local keywords_map
do
  local keywords = request('keywords')
  local map_values = request('!.table.map_values')
  keywords_map = map_values(keywords)
end

local str_match = string.match

-- Export:
return
  function(str)
    if not is_string(str) then return false end

    return
      str_match(str, identifier_pattern) and
      not keywords_map[str]
  end

--[[
  2016
  2026-06-18
]]
