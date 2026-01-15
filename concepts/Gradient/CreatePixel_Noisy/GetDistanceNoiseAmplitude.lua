-- Get noise amplitude

-- Last mod.: 2026-01-13

--[[
  Distance-dependent noise amplitude function

  Maps value from [0.0, 1.0] to another value in [0.0, 1.0].

  That is the essence of "plasm" pattern: noise is dependent of distance
  between two points.
]]
local GetNoiseAmplitude =
  function(self, Distance)
    --[[
      In this "universe" maximum distance is 1.0. Not infinity.

      For human-pleasant results we _don't_ want linearity:

        For half-distance result ought to be larger or smaller
        than half-result for distance:

          Noise(Distance / 2) != Noise(Distance) / 2

      Try wilder functions!
    ]]

    return Distance ^ 2
  end

-- Exports:
return GetNoiseAmplitude

--[[
  2024-11-25
  2025-04-09
]]
