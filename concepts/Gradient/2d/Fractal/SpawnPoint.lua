-- Calculate color at given coordinates considering neighbors

-- Last mod.: 2025-04-11

local t2s = request('!.table.as_string')
local MixNumbers = request('!.number.mix_numbers')

local NormalizeDistances =
  function(Distances)
    local Sum = 0.0

    for Index = 1, #Distances do
      Sum = Sum + Distances[Index]
    end

    local NormalizedDistances = {}

    for Index = 1, #Distances do
      NormalizedDistances[Index] = Distances[Index] / Sum
    end

    return NormalizedDistances
  end

--[[
  Spawn color as average of neighbors

  In this implementation there can be three or four neighbors.
  But algorithm can be generalized.
]]
local SpawnPoint =
  function(self, Point, ...)
    local Neighbors = {}
    for Index = 1, select('#', ...) do
      local Point = select(Index, ...)
      if self:GetColor(Point) then
        table.insert(Neighbors, Point)
      end
    end

    local NumNeighbors = #Neighbors

    local DistancesTo = {}
    for Index = 1, NumNeighbors do
      local Neighbor = Neighbors[Index]
      DistancesTo[Index] = self:CalcDistance(Point, Neighbor)
    end
    -- print('DistancesTo', t2s(DistancesTo))

    local ColorsOf = {}
    for Index = 1, NumNeighbors do
      local Neighbor = Neighbors[Index]
      ColorsOf[Index] = self:ObservePoint(Neighbor, Point)
    end
    -- print('ColorsOf', t2s(ColorsOf))

    local Influences = NormalizeDistances(DistancesTo)
    -- print('Influences', t2s(Influences))

    local Color = new(self.BaseColor)

    for ColorComponentIndex = 1, #Color do
      local WeightedSum = 0.0

      for NeighborIndex = 1, NumNeighbors do
        WeightedSum =
          WeightedSum +
          ColorsOf[NeighborIndex][ColorComponentIndex] * Influences[NeighborIndex]
        --[[
        print(
          ('[%d][%d] = %.2f'):
          format(ColorComponentIndex, NeighborIndex, WeightedSum)
        )
        ]]
      end

      Color[ColorComponentIndex] = WeightedSum
    end
    -- print('Color', t2s(Color))

    self:SetColor(Color, Point)
  end

-- Exports:
return SpawnPoint

--[[
  2025-04-11
]]
