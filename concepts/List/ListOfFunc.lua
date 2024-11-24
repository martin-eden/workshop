-- Apply function to each element in list. Return new list

-- Last mod.: 2024-11-24

-- Imports:
local ApplyFunc = request('FuncToList')

-- Exports:
return
  function(Func, List)
    local Result = new(List)

    ApplyFunc(Func, Result)

    return Result
  end

--[[
  2024-10-24
  2024-11-24
]]
