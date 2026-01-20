-- Create pixel given it's position and neighbors

--[[
  Author: Martin Eden
  Last mod.: 2026-01-20
]]

-- Imports:
local GetInfluenceOf = request('^.TwoPoints.GetInfluenceOf')

--[[
  For given pixel coordinate and "parent pixels" coordinates
  calculate their distance-dependent influences.
]]
local CalcInfluences =
  function(NewCoords, Parents)
    --[[
      That's vector of inverse distances to parents

      In most cases sum of terms is less than 1.0.
      We call that gap between sum and 1.0 "chaotism".
      That's our freedom for randomness.
    ]]

    local NumParents = #Parents

    --[[
      Calculate influences for each parent

      Simple case to think is 1-d point C for "ACB". DistancesTo are 1
      and two parents. So each parent influence is 1 / 2.
    ]]
    local Influences = {}
    for i = 1, NumParents do
      local Influence = GetInfluenceOf(NewCoords, Parents[i]) / NumParents
      table.insert(Influences, Influence)
    end

    --[[
      Chaotism is degree of our freedom

      That's what left after subtracting parents influences from 1.0.
    ]]
    local Chaotism = 1.0
    for i = 1, NumParents do
      Chaotism = Chaotism - Influences[i]
    end
    assert(Chaotism >= 0.0)

    --[[
      Here sum of influences plus chaotism is exactly one
    ]]

    return Influences
  end

-- Exports:
return CalcInfluences

--[[
  2025-04-23
  2026-01-13
  2026-01-14
  2026-01-19
  2026-01-20
]]
