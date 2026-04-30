-- Make given table formally comply to reference template

--[[
  Author: Martin Eden
  Last mod.: 2026-04-30
]]

--[[
  Well, there is no much sense in trying to keep Sample structure
  consistent if it does not have values with same types as
  in Reference.
]]

-- Imports:
local merge = request('!.table.merge')
local patch = request('!.table.patch')
local Reference = request('^.data.reference_structure')

local fix_structure =
  function(Sample)
    merge(Sample, Reference)
    patch(Sample, Reference)
  end

-- Export:
return fix_structure

--[[
  2020 #
  2024 #
  2026-04-30
]]
