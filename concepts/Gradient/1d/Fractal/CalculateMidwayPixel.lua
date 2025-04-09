-- Calculate midway pixel with noise

-- Last mod.: 2025-04-09

-- Imports:
local GetDistance = request('!.number.integer.get_distance')
local GetMiddleInt = request('!.number.integer.get_middle')
local MixFloats = request('!.number.mix_numbers')
local Clamp = request('!.number.constrain')

--[[
  Calculate midway pixel with distance-dependent noise

  Returns pixel in internal format.

  On fail returns nothing.
]]
local CalculateMidwayPixel =
  function(self, LeftPixel, RightPixel)
    local Distance = GetDistance(LeftPixel.Index, RightPixel.Index)

    assert(Distance >= 1)

    if (Distance == 1) then
      return
    end

    local NormalizedDistance = Distance / self.MaxDistance

    local MidIndex = GetMiddleInt(LeftPixel.Index, RightPixel.Index)

    local LeftColorPortion =
      1.0 - GetDistance(LeftPixel.Index, MidIndex) / Distance

    -- Calculate color components
    local Color = new(self.BaseColor)

    for Index in ipairs(Color) do
      local Value
      do
        local LeftColor = LeftPixel.Color[Index]
        local RightColor = RightPixel.Color[Index]
        local Noise = self:MakeDistanceNoise(NormalizedDistance)

        Value = MixFloats(LeftColor, RightColor, LeftColorPortion)
        Value = Value + Noise
        Value = Clamp(Value, 0.0, 1.0)
      end
      Color[Index] = Value
    end

    return { Index = MidIndex, Color = Color }
  end

-- Exports:
return CalculateMidwayPixel

--[[
  2024-09 #
  2024-11 # # # #
  2025-04-09
]]
