-- Invert table

--[[
  Author: Martin Eden
  Last mod.: 2025-11-12
]]

--[[
  Swaps keys with values. Used for simple substitution tables

  Example:

    { [1] = 'a', [2] = 'b' } -> { ['a'] = 1, ['b'] = 2 }
]]

return
  function(table)
    local result = { }
    for key, val in pairs(table) do
      result[val] = key
    end
    return result
  end

--[[
  2019 #
  2025 #
  2026-08-19
]]
