-- Observe point (with distance noise)

-- Last mod.: 2025-04-11

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

    local Distance = self:CalcDistance(OurPoint, OtherPoint)
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
]]
