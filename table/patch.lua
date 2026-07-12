-- Replace values to values from another table

--[[
  Author: Martin Eden
  Last mod.: 2026-07-12
]]

--[[
  Existing values are overwritten:
    { a = 'A'}, { a = 'X' } -> { a = 'X' }

  New values are not added:
    { a = 'A'}, { b = 'B' } -> { a = 'A' }
]]

-- Imports:
local apply_table = request('apply_table')

local Rules =
  {
    { has_a = true, has_b = true, action = 'replace' },
  }

local patch =
  function(Result, Additions)
    apply_table(Result, Additions, Rules)
  end

-- Exports:
return patch

--[[
  2016 #
  2024 # #
  2025 #
  2026-04-30
]]
