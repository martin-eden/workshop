-- Plasm generator interface

-- Last mod.: 2025-04-04

-- Exports:
return
  {
    -- [Config]

    -- Image line length
    ImageLength = 60,

    -- Scaling factor
    Scale = 1.0,

    -- Flag to create tileable pattern
    OnRing = false,

    -- Distance scaling function [0.0, 1.0] -> [0.0, 1.0]
    TransformDistance = request('TransformDistance'),

    -- Type of color. Three-floats list for rgb, one-float list for grayscale.
    BaseColor = request('!.concepts.Image.Color.Rgb'),

    -- [Main]

    -- Generate 1-D gradient
    Run = request('Run'),

    -- Result image line
    Image = {},

    -- [Internal]

    -- Recursive filler
    Plasm = request('Plasm'),

    -- Gap between leftmost and rightmost pixels. Calculated in Run()
    MaxGap = 0,

    -- Set pixel
    SetPixel = request('SetPixel'),

    -- Midway pixel calculator
    CalculateMidwayPixel = request('CalculateMidwayPixel'),

    -- Noise function [0.0, 1.0] -> [-1.0, 1.0]
    MakeDistanceNoise = request('MakeDistanceNoise'),
  }

--[[
  2024-09-30
  2024-11-06
  2024-11-24
  2025-03-28
  2025-04-04
]]
