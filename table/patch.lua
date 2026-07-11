-- Replace values to values from another table

--[[
  Author: Martin Eden
  Last mod.: 2026-07-11
]]

--[[
  Existing values are overwritten:
    { a = 'A'}, { a = 'X' } -> { a = 'X' }

  New values are not added:
    { a = 'A'}, { b = 'B' } -> { a = 'A' }
]]

-- Imports:
local apply_table = request('apply_table')

local patch =
  function(Result, Additions)
    assert_table(Result)

    if is_nil(Additions) then
      return
    end

    assert_table(Additions)

    local Rules =
      {
        { has_a = true, has_b = true, action = 'use_b' },
        { has_a = false, has_b = true, action = 'use_a' },
      }

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
