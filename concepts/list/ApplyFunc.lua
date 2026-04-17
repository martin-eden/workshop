-- Modify list by applying function to each element. Returns list

--[[
  Here we're breaking functional paradigm "result of function is new
  value". We're modifying argument. It's practical.
]]

-- Last mod.: 2024-11-25

-- Exports:
return
  function(Func, List)
    assert_function(Func)
    assert_table(List)

    for Index = 1, #List do
      List[Index] = Func(List[Index])
    end

    return List
  end

--[[
  2024-11-24
]]
