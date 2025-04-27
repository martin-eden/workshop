-- Get color of pixel in matrix

-- Last mod.: 2025-04-27

-- Imports:
local Line_GetColor = request('^.Line.GetColor')

local GetColor =
  function(Matrix, Point)
    local LineIndex = Point[1]
    local ColumnIndex = Point[2]

    local Line = Matrix[LineIndex]

    if not Line then
      return
    end

    return Line_GetColor(Line, ColumnIndex)
  end

-- Exports:
return GetColor

--[[
  2025-04-27
]]
