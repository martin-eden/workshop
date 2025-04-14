-- Calculate distance between two 2-d points

-- Last mod.: 2025-04-12

--[[
  Some distance func normed to <.MaxDistance>
]]
local CalcDistance =
  function(self, PointA, PointB)
    return
      (
        math.max(
          math.abs(PointB.X - PointA.X),
          math.abs(PointB.Y - PointA.Y)
        )
      ) /
      self.MaxDistance
  end

-- Exports:
return CalcDistance

--[[
  2025-04-11
  2025-04-12
]]
