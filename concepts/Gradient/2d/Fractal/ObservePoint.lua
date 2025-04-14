-- Observe point (with distance noise)

-- Last mod.: 2025-04-14

local ApplyFunc = request('!.concepts.List.ApplyFunc')
local SymmetricRandom = request('!.number.float.symmetric_random')
local Clamp = request('!.number.constrain')

--[[
  Return color of distant point

  Distance noise applies.

  On fail returns nothing.
]]
local ObservePoint =
  function(self, OtherPoint, OurPoint)
    assert(self:IsValidCoord(OurPoint))

    local OtherColor = self:GetColor(OtherPoint)

    if not OtherColor then
      return
    end

    assert(not self:GetColor(OurPoint))

    local Distance = self:CalcDistance(OurPoint, OtherPoint)

    Distance = self.Scale * Distance
    Distance = Clamp(Distance, 0.0, 1.0)

    local Noise = self:GetDistanceNoise(Distance)

    local ObservedColor = new(OtherColor)

    local AddNoise =
      function(ColorComponent)
        local ObservedComponent

        ObservedComponent = ColorComponent + SymmetricRandom() * Noise
        ObservedComponent = Clamp(ObservedComponent, 0.0, 1.0)

        return ObservedComponent
      end

    ApplyFunc(AddNoise, ObservedColor)

    return ObservedColor
  end

-- Exports:
return ObservePoint

--[[
  2025-04-11
  2025-04-14
]]
