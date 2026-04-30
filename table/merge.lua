-- Add values from another table

--[[
  Author: Martin Eden
  Last mod.: 2025-04-21
]]

--[[
  Existing values are preserved:
    { a = 'A'}, { a = 'X' } -> { a = 'A' }

  New values are added:
    { a = 'A'}, { b = 'B' } -> { a = 'A', b = 'B' }
]]

-- Imports:
local apply_table = request('apply_table')

local merge
merge =
  function(Result, Additions)
    assert_table(Result)

    if is_nil(Additions) then
      return Result
    end

    local Rules =
      {
        { HasA = true, HasB = true, Action = 'use_a' },
        { HasA = false, HasB = true, Action = 'use_b' },
      }

    apply_table(Result, Additions, Rules)

    return Result
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
]]
