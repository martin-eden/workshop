-- Fit number into given range

-- Last mod.: 2024-11-24

--[[
  Basically it's classic constrain() (aka clamp()) but here
  we're passing range as list, not as two arguments.
]]

-- Imports:
local Clamp = request('!.number.constrain')

--[[
  Fit number to given range

  Input
    Number
    Range
      [1] - min
      [2] - max
  Output
    number
]]
local FitToRange =
  function(Number, Range)
    return Clamp(Number, Range[1], Range[2])
  end

-- Exports:
return FitToRange

--[[
  2024-11-24
]]
