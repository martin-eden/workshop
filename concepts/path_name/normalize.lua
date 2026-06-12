-- Normalize pathname

--[[
  Author: Martin Eden
  Last mod.: 2026-06-12
]]

-- Imports:
local parse_pathname = request('parse')

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
