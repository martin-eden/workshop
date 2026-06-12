-- Compile list of names to directory path

--[[
  Author: Martin Eden
  Last mod.: 2026-06-12
]]

-- Imports:
local list_to_str = request('!.concepts.list.to_string')

local names_sep = '/'

local pathname_to_str =
  function(Pathname)
    return list_to_str(Pathname, names_sep)
  end

-- Export:
return pathname_to_str

--[[
  2026-06-12
]]
