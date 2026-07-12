-- Keep in table A only keys that are present in table B

--[[
  Author: Martin Eden
  Last mod.: 2026-07-12
]]

-- Imports:
local apply_table = request('apply_table')

local Rules =
  {
    { has_a = true, has_b = true, action = 'keep' },
    { has_a = true, has_b = false, action = 'remove' },
    { has_a = false, has_b = true, action = 'remove' },
  }

local intersect_set =
  function(A, B)
    apply_table(A, B, Rules)
  end

-- Export:
return intersect_set

--[[
  2026-07-12
]]
