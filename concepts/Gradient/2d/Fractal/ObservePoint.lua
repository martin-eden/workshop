-- Observe point (with distance noise)

-- Last mod.: 2025-04-16

local ClampUi = request('!.number.constrain_ui')
local SymmetricRandom = request('!.number.float.symmetric_random')
local ApplyFunc = request('!.concepts.List.ApplyFunc')

--[[
  Return color of distant point

  Distance noise applies.
]]
local ObservePoint =
  function(self, OtherPoint, OurPoint)
    local OtherColor = self:GetPixel(OtherPoint)

    if not OtherColor then
      return
    end

    local Distance = self:CalcDistance(OurPoint, OtherPoint)

    Distance = self.Scale * Distance

    Distance = ClampUi(Distance)

    local NoiseAmpl = self:GetDistanceNoiseAmplitude(Distance)

    local ObservedColor = new(OtherColor)

    local AddNoise =
      function(ColorComponent)
        local ObservedComponent

        ObservedComponent = ColorComponent + SymmetricRandom() * NoiseAmpl
        ObservedComponent = ClampUi(ObservedComponent)

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
  2025-04-16
]]
