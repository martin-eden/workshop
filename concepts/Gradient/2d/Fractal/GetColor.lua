-- Get image's pixel color

-- Last mod.: 2025-04-11

--[[
  Get color by given coordinates from image

  On fail returns nil.
]]
local GetPixel =
  function(self, Point)
    if not self:IsValidCoord(Point) then
      return
    end

    local x = Point.X
    local y = Point.Y
    local Image = self.Image

    if
      is_nil(Image[y]) or
      is_nil(Image[y][x])
    then
      return
    end

    -- print(('GetColor(%d, %d) = %.2f'):format(x, y, Image[y][x][1]))

    return Image[y][x]
  end

-- Exports
return GetPixel

--[[
  2025-04-11
]]
