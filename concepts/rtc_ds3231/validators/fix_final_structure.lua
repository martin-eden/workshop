--[[
  Make given table formally comply to reference template.

  Missing keys added. Mismatched value types are set to match
  corresponding types in reference table.
]]

-- Last mod.: 2024-11-11

-- Imports:
local Merge = request('!.table.merge')
local SoftPatch = request('!.table.soft_patch')

local Reference = request('^.data.reference_structure')

-- Exports:
return
  function(Sample)
    Merge(Sample, Reference)
    SoftPatch(Sample, Reference)
  end

--[[
  2020-09-13
  2024-11-11
]]
