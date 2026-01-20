-- Create pixel given it's position and neighbors

--[[
  Author: Martin Eden
  Last mod.: 2026-01-20
]]

-- Imports:
local t2s = request('!.table.as_string')
local DistanceTo = request('!.concepts.Geometry.TwoPoints.GetDistance')

--[[
  Spawn pixel at given position given knowledge about position of
  "parent pixels".
]]
local CalcInfluences =
  function(NewCoords, Parents)
    --[[
      That's sum of parents colors weighted by distance to them

      In most cases weighted sum of distances is less than 1.0.
      We call that distance from that sum to 1.0 "chaotism".
      That's our freedom for randomness.
    ]]

    -- print('NewCoords')
    -- print(t2s(NewCoords))

    -- print('Parents')
    -- print(t2s(Parents))

    local NumParents = #Parents

    --[[
      Calculate influences for each parent

      Simple case to think is 1-d point C for "ACB". DistancesTo are 1
      and two parents. So each parent influence is 1 / 2.
    ]]
    local Influences = {}
    for i = 1, NumParents do
      local Distance = DistanceTo(NewCoords, Parents[i])
      -- If zero distance..
      if (Distance == 0) then
        --[[
          We don't want zero distance. It will make singularity.

          Zero distance may mean same point. Or maybe distance
          function just wanted to return zero.

          Anyway, that's fail. If same point -- we should not be
          called with reference to itself as parent. If zero distance
          -- we don't know what's influence of this parent. (For
          one parent with zero distance we can just copy it's color,
          but what to do for several zero-distance parents?)
        ]]
        error('[Gradient.CalcInfluences] Zero distance to parent point.')
      end
      local Influence = (1 / Distance) / NumParents
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
    -- print('Chaotism', Chaotism)

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
]]
