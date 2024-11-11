-- Check that given table has required fields and value types

-- Last mod.: 2024-11-11

-- Imports:
local VerifyStructure = request('!.table.verify_structure')
local Reference = request('^.data.reference_structure')

-- Exports:
return
  function(Sample)
    local TypesMatching = true
    if not VerifyStructure(Sample, Reference, TypesMatching) then
      coroutine.yield()
    end
  end

--[[
  2020-09
  2024-11
]]
