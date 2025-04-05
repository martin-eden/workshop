-- Plasm generator interface

-- Last mod.: 2025-04-06

-- Exports:
return
  {
    -- [Before]

    -- Image line length
    ImageLength = 60,

    -- Color format: "Gs" for grayscale, "Rgb" for RGB
    ColorFormat = 'Gs',

    -- Scaling factor
    Scale = 1.0,

    -- Distance scaling function [0.0, 1.0] -> [0.0, 1.0]
    TransformDistance = request('TransformDistance'),

    -- [At]

    -- Generate 1-D gradient
    Run = request('Run'),

    -- [After]

    -- Result image line
    Line = {},

    -- [Internal]

    -- Type of color. Filled in Run()
    BaseColor = nil,

    -- Recursive filler
    Plasm = request('Plasm'),

    -- Distance between leftmost and rightmost pixels. Calculated in Run()
    MaxDistance = 0,

    -- Set pixel
    SetPixel = request('SetPixel'),

    -- Midway pixel calculator
    CalculateMidwayPixel = request('CalculateMidwayPixel'),

    -- Noise function [0.0, 1.0] -> [-1.0, 1.0]
    MakeDistanceNoise = request('MakeDistanceNoise'),
  }

--[[
  2024-09 #
  2024-11 # #
  2025-03 #
  2025-04-04
  2025-04-05
  2024-04-06
]]
