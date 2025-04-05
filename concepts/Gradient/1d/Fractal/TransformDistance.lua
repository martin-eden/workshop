-- Distance transformation function

-- Last mod.: 2025-03-28

--[[
  Distance transformation function maps value from [0.0, 1.0]
  to another value in [0.0, 1.0].

  That is the essence of "plasm" pattern. Noise is proportional to
  distance and distance is pre-processed here.

  Try plugging wilder functions!
]]

return
  function(self, Distance)
    return Distance
  end

--[[
  2024-11-25
]]
