-- Interface to Ranges Tree

--[[
  Author: Martin Eden
  Last mod.: 2026-05-05
]]

local Interface =
  {
    create_range = request('Range.create'),
    create_ranges_tree = request('RangesTree.create'),
    create_bits_value = request('BitsValue.create'),
    create_string_value = request('StringValue.create'),
    apply_ranges = request('apply_ranges'),
  }

-- Export:
return Interface

--[[
  2026-05-05
]]
