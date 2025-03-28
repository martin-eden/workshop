-- Return random color

-- Last mod.: 2025-03-28

-- Imports:
local Random = math.random
local ApplyFunc = request('!.concepts.List.ApplyFunc')

--[[
  UI in this context will mean "unit interval". Range [0.0, 1.0].
]]

local GetRandom_Ui =
  function()
    return Random()
  end

local CreateRandomColor =
  function(self)
    local Result = new(self.BaseColor)

    ApplyFunc(GetRandom_Ui, Result)

    return Result
  end

-- Exports:
return CreateRandomColor

--[[
  2024-09-30
  2024-11-06
  2024-11-24
]]
