-- Distance transformation function

-- Last mod.: 2025-04-09

--[[
  Distance transformation function

  Maps value from [0.0, 1.0] to another value in [0.0, 1.0].

  That is the essence of "plasm" pattern. Noise is proportional to
  distance and distance is pre-processed here.
]]
local TransformDistance =
  function(self, Distance)
    --[[
      In this "universe" maximum distance is 1.0. Not infinity.

      For human-pleasant results we _don't_ want fractal to
      be scale-invariant.

        ( That's when we have transitivity: D(A, B) + D(B, C) == D(A, C)
          Fractal will be same at any scale. It's boring.
        )

      Try plugging even wilder functions!
    ]]

    return Distance ^ 2
  end

-- Exports:
return TransformDistance

--[[
  2024-11-25
  2025-04-09
]]
