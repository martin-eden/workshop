-- Calculate pixel in center of image rectangle

-- Last mod.: 2025-04-04

-- Imports:
local IntMid = request('!.number.integer.get_middle')
local FloatMid = request('!.number.float.get_middle')
local Clamp = request('!.number.constrain')

-- See [Plasm] for parameters notation
local CalculateMidwayPixel =
  function(self, LU, RU, LB, RB)
    local X = IntMid(LU.X, RU.X)
    local Y = IntMid(LU.Y, LB.Y)
    local Color = new(self.BaseColor)

    for Index in ipairs(Color) do
      local Value =
        FloatMid(
          LU.Color[Index],
          RU.Color[Index],
          LB.Color[Index],
          RB.Color[Index]
        )

      Value = Clamp(Value, 0.0, 1.0)

      Color[Index] = Value
    end

    return { X = X, Y = Y, Color = Color }
  end

-- Exports:
return CalculateMidwayPixel

--[[
  2025-04-04
]]
