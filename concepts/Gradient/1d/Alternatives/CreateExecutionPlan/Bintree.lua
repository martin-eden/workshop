-- .CreateExecutionPlan() replacement with middle divisions

-- Last mod.: 2025-04-26

-- Imports:
local GetIntMid = request('!.number.integer.get_middle')

--[[

   1   2   3   4   5
  [L] [.] [.] [.] [R]

  produces

    (3 1 5)
    (2 1 3)
    (4 3 5)
]]
local Divide
Divide =
  function(Left, Right, Result)
    if (Right - Left <= 1) then
      return
    end

    local Mid = GetIntMid(Left, Right)

    if (Mid == Left) then
      return
    end

    table.insert(Result, { Mid, Left, Right })

    Divide(Left, Mid, Result)
    Divide(Mid, Right, Result)
  end

local CreateExecutionPlan =
  function(self)
    local Left = 1
    local Right = self.Line.Length

    local Result = {}

    Divide(Left, Right, Result)

    return Result
  end

-- Exports:
return CreateExecutionPlan

--[[
  2024-09 #
  2024-10 #
  2024-11 # # # #
  2025-04-09
  2025-04-16
  2025-04-23
  2025-04-26
]]
