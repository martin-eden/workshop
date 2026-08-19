-- Invert table

--[[
  Author: Martin Eden
  Last mod.: 2025-08-19
]]

--[[
  Swaps keys with values. Used for simple substitution tables

  Example:

    { [1] = 'a', [2] = 'b' } -> { ['a'] = 1, ['b'] = 2 }
]]

-- Export:
return
  function(Table)
    assert_table(Table)

    local Result = { }

    for Key, Value in pairs(Table) do
      Result[Value] = Key
    end

    return Result
  end

--[[
  2019 #
  2025 #
  2026-08-19
]]
