-- Normalize pathname

--[[
  Author: Martin Eden
  Last mod.: 2026-04-23
]]

-- Imports:
local parse_pathname = request('!.concepts.path_name.parse')

--[[
  Normalize string with Unix path-name.

  "/.////a" -> "a"
]]
local normalize_name =
  function(path_name)
    local result = parse_pathname(path_name)
    result = result.Directory .. result.Name
    return result
  end

-- Export:
return normalize_name

--[[
  2018-06
]]
