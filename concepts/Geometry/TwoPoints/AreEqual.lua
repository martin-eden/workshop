-- Return true if N-dim point coordinates are equal

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

return
  --[[
    Return true if two N-dimensional coordinates are equal

    Coordinates are just lists of integers.
    We like integer-coordinates space.
  ]]
  function(PointA, PointB)
    for i = 1, #PointA do
      if (PointA[i] ~= PointB[i]) then
        return false
      end
    end
    return true
  end

-- 2026-01-14
