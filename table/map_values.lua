-- Map table values to keys

--[[
  Author: Martin Eden
  Last mod.: 2026-05-26
]]

--[[
  Useful to check presence item in a list:

    { 'A', _ = 'a' } -> { A = true, a = true }
]]

local map_values =
  function(List)
    assert_table(List)

    local Result = { }

    for _, value in pairs(List) do
      Result[value] = true
    end

    return Result
  end

-- Export:
return map_values

--[[
  2016
  2024
  2025
]]
