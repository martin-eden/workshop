-- Merge destination table. Override existing fields in source table

-- Last mod.: 2024-11-11

-- Imports:
local Merge = request('merge')
local HardPatch = request('hard_patch')

local MergeAndPatch =
  function(Dest, Source)
    Merge(Dest, Source)
    HardPatch(Dest, Source)
    return Dest
  end

-- Exports:
return MergeAndPatch

--[[
  2024-11-11
]]
