-- Returns pixel's color with distance-dependent noise

-- Last mod.: 2025-04-23

-- Imports:
local ClampUi = request('!.number.constrain_ui')

local ObservePixel =
  function(Ours, Theirs, AnotherPoint, OurPoint)
    local Color = new(Theirs:GetPixel(AnotherPoint))

    local Distance =
      math.abs(OurPoint - AnotherPoint) / Ours.PixelsPerDistance

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
]]
