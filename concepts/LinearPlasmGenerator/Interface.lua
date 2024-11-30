-- Plasm generator interface

-- Last mod.: 2024-11-25

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

    -- [Main]

    -- Generate 1-D gradient
    Run = request('Run'),

    -- [Output]

    -- Result image
    Image = {},

    -- [Internal]

    -- Recursive filler
    Plasm = request('Plasm'),

    -- Gap between leftmost and rightmost pixels. Calculated in Run()
    MaxGap = 0,

    -- Set pixel
    SetPixel = request('SetPixel'),

    -- Generate random color
    GetRandomColor = request('GetRandomColor'),

    -- Midway pixel calculator
    CalculateMidwayPixel = request('CalculateMidwayPixel'),

    -- Noise function [0.0, 1.0] -> [-1.0, 1.0]
    MakeDistanceNoise = request('MakeDistanceNoise'),

    -- Distance scaling function [0.0, 1.0] -> [0.0, 1.0]
    TransformDistance = request('TransformDistance'),
  }

--[[
  2024-09-30
  2024-11-06
  2024-11-24
]]
