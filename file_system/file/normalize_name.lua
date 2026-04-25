-- Normalize pathname

--[[
  Author: Martin Eden
  Last mod.: 2026-04-25
]]

-- Imports:
local parse_pathname = request('!.concepts.path_name.parse')

--[[
  Normalize string with Unix path-name.

  "/.////a" -> "/a"
]]
local normalize_name =
  function(path_name)
    return parse_pathname(path_name).FullName
  end

-- Export:
return normalize_name

--[[
  2018-06
]]
