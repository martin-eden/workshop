-- Check that string is valid Lua name and is not a keyword

--[[
  Author: Martin Eden
  Last mod.: 2026-06-18
]]

-- Imports:
local Keywords_Map = request('keywords')

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
