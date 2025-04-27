-- Set color of element

-- Last mod.: 2025-04-27

local SetColor =
  function(Line, Point, Color)
    Line[Point] = Line[Point] or Color
  end

-- Exports:
return SetColor

--[[
  2025-04-27
]]
