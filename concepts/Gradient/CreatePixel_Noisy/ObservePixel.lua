-- Returns pixel's color with distance-dependent noise

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

-- Imports:
local ClampUi = request('!.number.constrain_ui')
local GetDistance = request('!.concepts.Geometry.TwoPoints.GetDistance')

local ObservePixel =
  function(Ours, Theirs, OurPoint, AnotherPoint)
    local Color = new(Theirs:GetPixel(AnotherPoint))

    local Distance =
      GetDistance(OurPoint, AnotherPoint) / Ours.PixelsPerDistance

    for ComponentIndex = 1, #Color do
      local ComponentValue =
        Color[ComponentIndex] + Ours:MakeDistanceNoise(Distance)

      ComponentValue = ClampUi(ComponentValue)

      Color[ComponentIndex] = ComponentValue
    end

    return Color
  end

-- Exports:
return ObservePixel

--[[
  2025-04-23
  2026-01-13
]]
