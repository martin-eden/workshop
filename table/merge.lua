-- Add values from another table

--[[
  Author: Martin Eden
  Last mod.: 2026-07-11
]]

--[[
  Existing values are preserved:
    { a = 'A'}, { a = 'X' } -> { a = 'A' }

  New values are added:
    { a = 'A'}, { b = 'B' } -> { a = 'A', b = 'B' }
]]

-- Imports:
local apply_table = request('apply_table')

local merge =
  function(Result, Additions)
    assert_table(Result)

    if is_nil(Additions) then
      return Result
    end

    local Rules =
      {
        { has_a = true, has_b = true, action = 'use_a' },
        { has_a = false, has_b = true, action = 'use_b' },
      }

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
