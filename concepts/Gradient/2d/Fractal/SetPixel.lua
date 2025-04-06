-- Set pixel in image

-- Last mod.: 2025-04-04

--[[
  Set pixel in image

  We're using internal custom format for pixels, but here
  we-re writing for export.
]]
local SetPixel =
  function(self, Pixel)
    local x = Pixel.X
    local y = Pixel.Y
    local Color = Pixel.Color

    local Image = self.Image

    if is_nil(Image[y]) then
      Image[y] = {}
    end

    Image[y][x] = Color

    -- print(('SetPixel(%d, %d, %.2f)'):format(x, y, Color[1]))
  end

-- Exports
return SetPixel

--[[
  2025-04-04
]]
