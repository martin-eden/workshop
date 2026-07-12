-- Add values from another table

--[[
  Author: Martin Eden
  Last mod.: 2026-07-12
]]

--[[
  Existing values are preserved:
    { a = 'A'}, { a = 'X' } -> { a = 'A' }

  New values are added:
    { a = 'A'}, { b = 'B' } -> { a = 'A', b = 'B' }
]]

-- Imports:
local apply_table = request('apply_table')

local Rules =
  {
    { has_a = false, has_b = true, action = 'replace' },
  }

local merge =
  function(Result, Additions)
    apply_table(Result, Additions, Rules)
  end

-- Exports:
return merge

--[[
  2016 # #
  2017 #
  2019 #
  2024 #
  2025 #
  2026-04-30
  2026-06-17
]]
