-- Get influence of other point

--[[
  Author: Martin Eden
  Last mod.: 2026-01-20
]]

-- Imports:
local GetDistanceTo = request('GetDistanceTo')

-- Exports:
return
  -- Get "influence" of other point
  function(OurPoint, AnotherPoint)
    -- Influence here is inverse of distance

    local Distance = GetDistanceTo(OurPoint, AnotherPoint)

    -- If zero distance..
    if (Distance == 0) then
      --[[
        We don't want zero distance. It will make singularity.

        Zero distance may mean same point. Or maybe distance
        function just wanted to return zero.

        Anyway, that's fail. If same point -- we should not be
        called with reference to itself. If just zero distance
        -- we can not apply arithmetic to infinities.
      ]]
      error('[CalcInfluenceOf] Zero distance to another point.')
    end

    return 1 / Distance
  end

--[[
  2026-01-20
]]
