-- Compile list of names to directory path

--[[
  Author: Martin Eden
  Last mod.: 2026-08-08
]]

-- Imports:
local Syntels = request('Syntels')
local list_to_str = request('!.concepts.list.to_string')

local sep = Syntels.separator

local pathname_to_str =
  function(Pathname)
    return list_to_str(Pathname, sep)
  end

-- Export:
return pathname_to_str

--[[
  2026-06-12
]]
