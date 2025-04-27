-- Get image's pixel color

-- Last mod.: 2025-04-27

-- Imports:
local Matrix_GetColor = request('!.concepts.Image.Matrix.GetColor')

--[[
  Get color by given coordinates from image
]]
local GetPixel =
  function(self, Point)
    return Matrix_GetColor(self.Image, { Point.Y, Point.X })
  end

-- Exports:
return GetPixel

--[[
  2025-04-11
  2025-04-16
  2025-04-27
]]
