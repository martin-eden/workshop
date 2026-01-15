-- Get normalized neighbor influence

--[[
  Author: Martin Eden
  Last mod.: 2026-01-13
]]

local GetDistance = request('!.concepts.Geometry.TwoPoints.GetDistance')

return
  --[[
    Get normalized influence for one of three N-dim points

    This is actually simple despite all strange words.

    1-d:

      A--N-----B
      1234567890

      We want to calculate new point N and we have points A and B.
      We want N be average of these two parents.

      It's obvious N will look more like A than B because it's
      closer to A.

      If it was exactly at A, "A's influence" would be 1.0.
      If it was exactly at B, A's influence would be 0.0.
      That's why it called "normalized".
  ]]
  function(NewPoint, PointA, PointB)
    --[[
      Assumption here is that new point lies between neighbors:

        d(New, A) + d(New, B) == d(A, B)
    ]]
    return GetDistance(NewPoint, PointA) / GetDistance(PointA, PointB)
  end

-- 2026-01-13
