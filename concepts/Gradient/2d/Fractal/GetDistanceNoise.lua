-- Return distance noise amplitude

-- Last mod.: 2025-04-11

--[[
  Return distance noise amplitude

  Distance is in unit interval [0.0, 1.0], noise amplitude is there too.
]]
local GetDistanceNoise =
  function(self, Distance)
    -- print(Distance)

    -- return 0.0
    return Distance ^ 0.9
  end

-- Exports:
return GetDistanceNoise

--[[
  2025-04-11
]]
