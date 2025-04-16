-- Return true if point belongs to our image

-- Last mod.: 2025-04-11

local IsValidCoord =
  function(self, Point)
    return
      (Point.X >= 1) and (Point.X <= self.ImageWidth) and
      (Point.Y >= 1) and (Point.Y <= self.ImageHeight)
  end

-- Exports:
return IsValidCoord

--[[
  2025-04-11
]]
