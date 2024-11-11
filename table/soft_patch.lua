-- Shortcut to change values only if they are wrong type

-- Last mod.: 2024-11-11

-- Imports:
local Patch = request('patch')

local SoftPatch =
  function(Dest, PatchTable)
    return Patch(Dest, PatchTable, true)
  end

-- Exports:
return SoftPatch

--[[
  2024-11-11
]]
