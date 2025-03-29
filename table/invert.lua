-- Invert table

-- Last mod.: 2025-03-30

--[[
  Invert table - for simple substitution tables

  Examples:

    { 'value_a', 'value_b' } -> { value_a = 1, value_b = 2 }

  See also

    * [get_paths] to get a list of paths to values in tree
]]
local InvertTable =
  function(Table)
    assert_table(Table)

    local Result = {}

    for Key, Value in pairs(Table) do
      Result[Value] = Key
    end

    return Result
  end


-- Exports:
return InvertTable

--[[
  2019-12-01
  2025-03-30
]]
