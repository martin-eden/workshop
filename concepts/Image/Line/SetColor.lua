-- Set color of element

-- Last mod.: 2025-04-27

local SetColor =
  function(Line, Point, Color)
    --[[
    if not Line[Point] then
      print(('Line.SetColor(%d) = %.2f'):format(Point, Color[1]))
    end
    --]]

    Line[Point] = Line[Point] or Color
  end

-- Exports:
return SetColor

--[[
  2025-04-27
]]
