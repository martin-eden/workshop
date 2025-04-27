-- Set image pixel's color

-- Last mod.: 2025-04-27

-- Imports:
local Matrix_SetColor = request('!.concepts.Image.Matrix.SetColor')

--[[
  Set pixel's color in image
]]
local SetColor =
  function(self, Point, Color)
    Matrix_SetColor(self.Image, { Point.Y, Point.X }, Color)
  end

-- Exports:
return SetColor

--[[
  2025-04-04
  2025-04-11
  2025-04-15
  2025-04-16
  2025-04-20
  2025-04-27
]]
