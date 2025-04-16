-- Calculate color at given coordinates considering neighbors

-- Last mod.: 2025-04-16

-- Imports:
local IntMid = request('!.number.integer.get_middle')
local MixNumbers = request('!.number.mix_numbers')

--[[
  Spawn color as average of two neighbors

  Unlike 1-d implementation, to calculate average color with noise
  we "observe" point A and point B. Each observation introduces
  distance noise. Then we mix those observations respecting
  distances.
]]
local SpawnMidpoint =
  function(self, NeibA, NeibB)
    local Midpoint =
      {
        X = IntMid(NeibA.X, NeibB.X),
        Y = IntMid(NeibA.Y, NeibB.Y),
      }

    if self:GetPixel(Midpoint) then
      return
    end

    local DistToA = self:CalcDistance(Midpoint, NeibA)
    local DistToB = self:CalcDistance(Midpoint, NeibB)
    local TotalDist = DistToA + DistToB

    local NeibAInfluence = DistToB / TotalDist

    local NeibAColor = self:ObservePoint(NeibA, Midpoint)
    local NeibBColor = self:ObservePoint(NeibB, Midpoint)

    local Color = new(self.BaseColor)

    for ColorComponentIndex = 1, #Color do
      Color[ColorComponentIndex] =
        MixNumbers(
          NeibAColor[ColorComponentIndex],
          NeibBColor[ColorComponentIndex],
          NeibAInfluence
        )
    end

    self:SetPixel(Color, Midpoint)
  end

-- Exports:
return SpawnMidpoint

--[[
  2025-04-11
  2025-04-14
  2025-04-16
]]
