-- Apply function to each element in list. Return new list

-- Last mod.: 2024-10-24

-- Exports:
return
  function(Func, List)
    assert_function(Func)
    assert_table(List)

    local Result = {}

    for Key, Value in ipairs(List) do
      local FuncValue = Func(Value)
      table.insert(Result, FuncValue)
    end

    return Result
  end

--[[
  2024-10-24
]]
