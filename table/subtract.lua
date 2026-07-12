-- From table A remove keys that are present in table B

--[[
  Author: Martin Eden
  Last mod.: 2026-07-12
]]

-- Imports:
local apply_table = request('apply_table')

local Rules =
  {
    { has_a = true, has_b = true, action = 'remove' },
  }

local subtract_table =
  function(A, B)
    apply_table(A, B, Rules)
  end

-- Export:
return subtract_table

--[[
  2018
  2026-07-12
]]
