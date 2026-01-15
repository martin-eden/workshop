-- Move current point toward destination in N-dimensional space

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

local AreSame = request('!.concepts.Geometry.TwoPoints.AreEqual')

--[[
  Move our point toward another point by one step

  Modifies Our Point coordinates.

  If we're already at destination, move nowhere.

  N-dim integer coordinates space. When distance is rectilinear metric
  (aka Manhattan distance) there are many paths between two points.
]]
local MoveToward =
  function(OurPoint, AnotherPoint)
    if AreSame(OurPoint, AnotherPoint) then
      return
    end
    for i = 1, #OurPoint do
      local CoordA = OurPoint[i]
      local CoordB = AnotherPoint[i]
      if (CoordA ~= CoordB) then
        if (CoordA < CoordB) then
          CoordA = CoordA + 1
        else
          CoordA = CoordA - 1
        end
        OurPoint[i] = CoordA
        return
      end
    end
  end

return MoveToward

-- 20226-01-14
