-- Normalize pathname

--[[
  Author: Martin Eden
  Last mod.: 2026-06-12
]]

-- Imports:
local pathname_from_str = request('pathname_from_str')
local pathname_to_str = request('pathname_to_str')

--[[
  Normalize string with Unix path-name.

  "/.////a" -> "/a"
]]
local normalize_name =
  function(path_name)
    return pathname_to_str(pathname_from_str(path_name))
  end

-- Export:
return normalize_name

--[[
  2018-06
]]
