-- Calculate midway pixel with noise

-- Last mod.: 2025-04-06

-- Imports:
local GetDistance = request('!.number.integer.get_distance')
local GetMiddleInt = request('!.number.integer.get_middle')
local GetMiddleFloat = request('!.number.float.get_middle')
local Clamp = request('!.number.constrain')

--[[
  Given left and right pixels calculate midway pixel,
  adding distance-dependent noise.

  Type TPixel

    { Index: int, Color: { 1=Red, 2=Green, 3=Blue: float_ui } }

  Input

    LeftPixel, RightPixel: TPixel

  Output

    TPixel
]]
local CalculateMidwayPixel =
  function(self, LeftPixel, RightPixel)
    local Distance = GetDistance(LeftPixel.Index, RightPixel.Index)

    assert(Distance >= 1)

    if (Distance == 1) then
      return
    end

    local NormalizedDistance = Distance / self.MaxDistance

    local Index = GetMiddleInt(LeftPixel.Index, RightPixel.Index)

    -- Calculate color components
    local Color = new(self.BaseColor)

    for Index in ipairs(Color) do
      local Noise = self:MakeDistanceNoise(NormalizedDistance)

      local Value
      Value = GetMiddleFloat(LeftPixel.Color[Index], RightPixel.Color[Index])
      Value = Value + Noise
      Value = Clamp(Value, 0.0, 1.0)

      Color[Index] = Value
    end

    return { Index = Index, Color = Color }
  end

-- Exports:
return CalculateMidwayPixel

--[[
  2024-09 #
  2024-11 # # # #
]]
