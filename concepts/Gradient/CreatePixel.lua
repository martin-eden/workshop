-- Create pixel given it's position and neighbors

--[[
  Author: Martin Eden
  Last mod.: 2026-01-19
]]

-- (
-- Imports:
local ApplyFunc = request('!.concepts.List.ApplyFunc')

-- Multiply list of numbers by value
local ScaleBy =
  function(Color, Scale)
    local Component_ScaleBy =
      function(ColorComponent)
        return ColorComponent * Scale
      end

    return ApplyFunc(Component_ScaleBy, Color)
  end
-- )

-- (
-- Sum numbers from another list with our list
local SumWith =
  function(OurList, AnotherList)
    for i = 1, #OurList do
      OurList[i] = OurList[i] + AnotherList[i]
    end
  end
-- )

-- Imports:
local t2s = request('!.table.as_string')
local DistanceTo = request('!.concepts.Geometry.TwoPoints.GetDistance')
local SpawnColor = request('!.concepts.Image.Color.SpawnColor')
local RandomizeColor = request('!.concepts.Image.Color.Randomize')

--[[
  Spawn pixel at given position given knowledge about position of
  "parent pixels".
]]
local CreatePixel =
  function(self, NewCoords, Parents)
    --[[
      That's sum of parents colors weighted by distance to them

      In most cases weighted sum of distances is less than 1.0.
      We call that distance from that sum to 1.0 "chaotism".
      That's our freedom for randomness.
    ]]

    print('Parents')
    print(t2s(Parents))

    local NumParents = #Parents

    local Distances = {}
    do
      for i = 1, NumParents do
        local Parent = Parents[i]
        local Distance = DistanceTo(NewCoords, Parent)
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
          error('[Gradient.CreatePixel] Zero distance to parent point.')
        end
        table.insert(Distances, Distance)
      end
    end

    print('Distances')
    print(t2s(Distances))

    --[[
      Calculate influences for each parent

      Simple case to think is 1-d point C for "ACB". Distances are 1
      and two parents. So each parent influence is 1 / 2.
    ]]
    local Influences = {}
    for i = 1, NumParents do
      local Influence = DistanceTo[i] / NumParents
      table.insert(Influences, Influence)
    end

    print('Influences')
    print(t2s(Influences))

    --[[
      Chaotism is degree of our freedom

      That's what left after subtracting parents influences from 1.0.
    ]]
    local Chaotism = 1.0
    for i = 1, NumParents do
      Chaotism = Chaotism - Influences[i]
    end
    assert(Chaotism >= 0.0)
    print('Chaotism', Chaotism)

    --[[
      Here sum of influences plus chaotism is exactly one

      So we'll just scale em and add up.
    ]]

    local Color = SpawnColor(self.Image.Settings.ColorFormat)
    do
      RandomizeColor(Color)
      ScaleBy(Color, Chaotism)
      print('Random Color'))
      print(t2s(Color))

      for i = 1, NumParents do
        local ParentColor = self.Image:GetPixel(Parents[i])
        local ScaledParentColor = new(ParentColor)
        ScaleBy(ParentColor, Influences[i])

        print('Parent Color'))
        print(t2s(ParentColor))

        SumWith(Color, ParentColor)
      end
    end
    print('Final Color'))
    print(t2s(Color))

    self.Image:SetPixel(NewCoords, Color)
  end

-- Exports:
return CreatePixel

--[[
  2025-04-23
  2026-01-13
  2026-01-14
  2026-01-19
]]
