-- Calculate color at given coordinates considering neighbors

-- Last mod.: 2025-04-14

local t2s = request('!.table.as_string')

local NormalizeNumbers =
  function(Numbers)
    local Sum = 0.0

    for Index = 1, #Numbers do
      Sum = Sum + Numbers[Index]
    end

    local NormalizedDistances = {}

    for Index = 1, #Numbers do
      NormalizedDistances[Index] = Numbers[Index] / Sum
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
    if self:GetPixel(Point) then
      return
    end

    -- self:PrintPoint(Point)

    local Neighbors = {}
    for Index = 1, select('#', ...) do
      local Point = select(Index, ...)
      if self:GetPixel(Point) then
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

    local Influences = new(DistancesTo)
    Influences = NormalizeNumbers(Influences)
    -- print('Influences', t2s(Influences))
    for NeighborIndex = 1, #DistancesTo do
      Influences[NeighborIndex] = 1 - Influences[NeighborIndex]
    end
    Influences = NormalizeNumbers(Influences)
    -- print('Influences', t2s(Influences))

    local ColorsOf = {}
    for Index = 1, NumNeighbors do
      local Neighbor = Neighbors[Index]
      ColorsOf[Index] = self:ObservePoint(Neighbor, Point)
    end
    -- print('ColorsOf', t2s(ColorsOf))

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
        --]]
      end

      Color[ColorComponentIndex] = WeightedSum
    end
    -- print('Color', t2s(Color))

    self:SetPixel(Color, Point)
  end

-- Exports:
return SpawnPoint

--[[
  2025-04-11
  2025-04-14
]]
