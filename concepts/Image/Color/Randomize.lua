-- Randomize components of given color

-- Last mod.: 2025-04-04

-- Imports:
local ApplyFunc = request('!.concepts.List.ApplyFunc')

-- Return number from unit interval [0.0, 1.0]
local GetRandom_Ui =
  function()
    return math.random()
  end

--[[
  Randomize color components

  Modifies given table!

  Fact that it returns table is just convenience feature.
]]
local Randomize =
  function(Color)
    ApplyFunc(GetRandom_Ui, Color)

    return Color
  end

-- Exports:
return Randomize

--[[
  2025-04-04
]]
