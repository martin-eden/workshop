-- Calculate distance between two 2-d points

-- Last mod.: 2025-04-15

--[[
  Some distance func
]]
local CalcDistance =
  function(self, PointA, PointB)
    return
      (
        math.abs(PointB.X - PointA.X) +
        math.abs(PointB.Y - PointA.Y)
      )
  end

-- Exports:
return CalcDistance

--[[
  2025-04-11
  2025-04-12
  2025-04-15
]]
