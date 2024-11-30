-- Return random color

-- Last mod.: 2024-11-25

-- Imports:
local BaseColor = request('!.concepts.Image.Color.Interface')
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
    local Result = new(BaseColor)

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
