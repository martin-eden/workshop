-- Calculate midway pixel with noise

-- Last mod.: 2025-03-28

-- Imports:
local GetGap = request('!.number.integer.get_gap')
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
    local Gap = GetGap(LeftPixel.Index, RightPixel.Index)

    assert(Gap >= 0)

    if (Gap == 0) then
      return
    end

    local Distance = Gap / self.MaxGap

    local Index = GetMiddleInt(LeftPixel.Index, RightPixel.Index)

    -- Calculate color components
    local Color = new(self.BaseColor)

    for Index in ipairs(Color) do
      local Noise = self:MakeDistanceNoise(Distance)

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
  2024-09-30
  2024-11-06
  2024-11-18
  2024-11-24
  2024-11-30
]]
