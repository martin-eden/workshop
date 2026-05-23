-- Keys comparator for sorting generic tables

--[[
  Author: Martin Eden
  Last mod.: 2026-05-23
]]

-- Imports:
local compare_values = request('compare_values')

local compare_keys =
  function(a, b)
    return compare_values(a.key, b.key)
  end

-- Export:
return compare_keys

--[[
  2016-09
  2017-09
]]
