-- "Independent" execution plan. Depends only of initial values

-- Last mod.: 2025-04-27

local IndependentExecutionPlan =
  function(self)
    if (self.Line.Length <= 2) then
      return {}
    end

    local Result = {}

    local Left = 1
    local Right = self.Line.Length

    for X = Left + 1, Right - 1 do
      table.insert(Result, { X, Left, Right })
    end

    return Result
  end

-- Exports:
return IndependentExecutionPlan

--[[
  2025-04-26
  2025-04-27
]]
