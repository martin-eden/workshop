-- Distance noise calculation

-- Last mod.: 2025-04-16

-- Imports:
local ClampUi = request('!.number.constrain_ui')
local SymmetricRandom = request('!.number.float.symmetric_random')
local ClampSui = request('!.number.constrain_sui')

-- Noise function [0.0, 1.0] -> [-1.0, 1.0]
local MakeDistanceNoise =
  function(self, Distance)
    Distance = ClampUi(self.Scale * Distance)

    local Noise
    Noise = self:GetDistanceNoiseAmplitude(Distance) * SymmetricRandom()
    Noise = ClampSui(Noise)

    return Noise
  end

-- Exports:
return MakeDistanceNoise

--[[
  2024-09-30
  2024-11-06
  2024-11-24
  2025-04-16
]]
