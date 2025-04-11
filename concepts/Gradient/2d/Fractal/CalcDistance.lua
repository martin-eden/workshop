-- Calculate distance between two 2-d points

-- Last mod.: 2025-04-11

--[[
  It's typical Euclidean distance normed to <.MaxDistance>
]]
local CalcDistance =
  function(self, PointA, PointB)
    return
      (
        (PointB.X - PointA.X) ^ 2 +
        (PointB.Y - PointA.Y) ^ 2
      ) ^ 0.5 /
      self.MaxDistance
  end

-- Exports:
return CalcDistance

--[[
  2025-04-11
]]
