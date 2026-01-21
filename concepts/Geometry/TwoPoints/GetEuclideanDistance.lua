-- Calculate traditional distance between two N-dim points

--[[
  Author: Martin Eden
  Last mod.: 2026-01-20
]]

return
  function(OurPoint, AnotherPoint)
    local DeltasSqSum = 0.0
    local Delta
    local Result

    for i = 1, #OurPoint do
      local Delta = math.abs(OurPoint[i] - AnotherPoint[i])
      DeltasSqSum = DeltasSqSum + Delta ^ 2
    end

    Result = DeltasSqSum ^ 0.5

    return Result
  end

--[[
  2026-01-20
]]
