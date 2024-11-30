-- Distance transformation function

-- Last mod.: 2024-11-25

--[[
  Distance transformation function maps value
  from [0.0, 1.0] to another value in [0.0, 1.0].

  Try plugging wilder functions!
]]

local DistanceIdentity =
  function(self, Distance)
    return Distance
  end

-- Exports:
return DistanceIdentity

--[[
  2024-11-25
]]
