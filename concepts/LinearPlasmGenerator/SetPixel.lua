-- Set pixel in our image

-- Last mod.: 2024-11-25

local SetPixel =
  function(self, Pixel)
    local Index = Pixel.Index
    local Color = Pixel.Color

    self.Image[Index] = Color
  end

-- Exports:
return SetPixel

--[[
  2024-11-24
]]
