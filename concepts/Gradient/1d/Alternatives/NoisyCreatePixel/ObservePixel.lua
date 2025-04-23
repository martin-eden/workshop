-- Returns pixel's color with distance-dependent noise

-- Last mod.: 2025-04-23

-- Imports:
local ClampUi = request('!.number.constrain_ui')

local ObservePixel =
  function(self, AnotherPoint, OurPoint, Theirs)
    local Color = new(Theirs:GetPixel(AnotherPoint))

    local Distance =
      math.abs(OurPoint - AnotherPoint) / (Theirs.Line.Length - 1)

    for ComponentIndex = 1, #Color do
      local ComponentValue =
        Color[ComponentIndex] + self:MakeDistanceNoise(Distance)

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
