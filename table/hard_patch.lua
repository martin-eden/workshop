-- Shortcut to overwrite values in destination table according to patch

-- Last mod.: 2024-11-11

-- Imports:
local Patch = request('patch')

local HardPatch =
  function(Dest, PatchTable)
    return Patch(Dest, PatchTable, false)
  end

-- Exports:
return HardPatch

--[[
  2024-11-11
]]
