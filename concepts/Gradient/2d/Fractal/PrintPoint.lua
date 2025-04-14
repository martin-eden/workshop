-- [Debug] Print point coordinates and color

-- Last mod.: 2025-04-12

local PrintPoint =
  function(self, Point, Name)
    local Name = Name or 'P'

    local Color = self:GetColor(Point)
    if Color then
      Color = ('%.2f'):format(Color[1])
    else
      Color = 'empty'
    end

    print(('%s (%d %d %s)'):format(Name, Point.X, Point.Y, Color))
  end

-- Exports:
return PrintPoint

--[[
  2025-04-11
  2025-04-12
]]
