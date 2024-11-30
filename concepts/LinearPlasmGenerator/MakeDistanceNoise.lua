-- Distance noise calculation

-- Last mod.: 2024-11-30

-- Imports:
local Clamp = request('!.number.constrain')
local SymmetricRandom = request('!.number.symmetric_random')

-- Noise function [0.0, 1.0] -> [-1.0, 1.0]
local MakeDistanceNoise =
  function(self, Distance)
    Distance = Clamp(self.Scale * Distance, 0.0, 1.0)

    local Noise = self:TransformDistance(Distance) * SymmetricRandom()

    Noise = Clamp(Noise, -1.0, 1.0)

    return Noise
  end

-- Exports:
return MakeDistanceNoise

--[[
  2024-09-30
  2024-11-06
  2024-11-24
]]
