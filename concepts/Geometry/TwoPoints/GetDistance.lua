-- Get distance between two N-dim points in so-called Manhattan coordinates

--[[
  Author: Martin Eden
  Last mod.: 2026-01-13
]]

--[[
  What is Manhattan coordinates

  Imagine square grid:

    *--*--
    |  |
    *--*--
    |  |

  Distance between two points is number of segments you have to
  travel to reach another point.

  It's always integer, not that irrational numbers that can't be
  expressed.

  It's easy to calculate: just sum horizontal and vertical differences
  (for 2-d).


  Why N-dim

  Because else someday I'll have to write it for 3-d. Why not 4-d, N-d?

  I don't like similar code, I'm not paid for doing shit. (And not paid
  for doing personal projects.)
]]

return
  --[[
    Calculate rectilinear distance for two N-points with integer coords
  ]]
  function(PointA, PointB)
    local Result = 0

    -- For 1-d case points can just be numbers:
    if is_number(PointA) then
      assert_number(PointB)

      Result = math.abs(PointA - PointB)

      return Result
    end

    for i = 1, #PointA do
      local CoordA = PointA[i]
      local CoordB = PointB[i]
      assert(CoordB)

      local Delta = math.abs(CoordA - CoordB)

      Result = Result + Delta
    end

    return Result
  end

-- 2026-01-13
