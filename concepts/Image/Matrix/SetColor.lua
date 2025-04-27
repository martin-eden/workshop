-- Set color for pixel in matrix

-- Last mod.: 2025-04-27

-- Imports:
local Line_SetColor = request('^.Line.SetColor')

--[[
  <Point> is a list of two coordinates: row and column
]]
local SetColor =
  function(Matrix, Point, Color)
    local LineIndex = Point[1]
    local ColumnIndex = Point[2]

    Matrix[LineIndex] = Matrix[LineIndex] or {}

    local Line = Matrix[LineIndex]

    Line_SetColor(Line, ColumnIndex, Color)
  end

-- Exports:
return SetColor

--[[
  2025-04-27
]]
