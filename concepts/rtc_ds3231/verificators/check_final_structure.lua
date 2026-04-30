-- Check that given table has required fields and value types

--[[
  Author: Martin Eden
  Last mod.: 2026-04-30
]]

-- Imports:
local values_are_same_type = request('!.table.values_are_same_type')
local Reference = request('^.data.reference_structure')

local check_final_structure =
  function(Sample)
    if not values_are_same_type(Sample, Reference) then
      coroutine.yield()
    end
  end

-- Export:
return check_final_structure

--[[
  2020 #
  2024 #
  2026-04-30
]]
