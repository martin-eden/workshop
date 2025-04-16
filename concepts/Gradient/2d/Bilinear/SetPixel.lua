-- Set image pixel's color

-- Last mod.: 2025-04-16

--[[
  Set pixel's color in image
]]
local SetColor =
  function(self, Color, Point)
    local x = Point.X
    local y = Point.Y
    local Image = self.Image

    if is_nil(Image[y]) then
      Image[y] = {}
    end

    Image[y][x] = Color

    -- print(('SetColor(%d, %d, %.2f)'):format(x, y, Color[1]))
  end

-- Exports
return SetColor

--[[
  2025-04-04
  2025-04-11
  2025-04-15
  2025-04-16
]]
