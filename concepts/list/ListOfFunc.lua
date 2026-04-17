-- Apply function to each element in list. Returns new list

-- Last mod.: 2024-11-25

-- Imports:
local ApplyFunc = request('ApplyFunc')

-- Exports:
return
  function(Func, List)
    return ApplyFunc(Func, new(List))
  end

--[[
  2024-10-24
  2024-11-24
]]
