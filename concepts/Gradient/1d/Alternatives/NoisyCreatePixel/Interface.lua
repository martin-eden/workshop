-- Export CreatePixel() function that introduces distance noise

-- Last mod.: 2025-04-28

-- Exports:
return
  {
    -- [Before]
    PixelsPerDistance = 400,
    GetDistanceNoiseAmplitude = request('GetDistanceNoiseAmplitude'),

    -- [At]
    Generate_CreatePixel = request('Generate_CreatePixel'),

    -- [Internals]
    MakeDistanceNoise = request('MakeDistanceNoise'),
    ObservePixel = request('ObservePixel'),
    CreatePixel = request('CreatePixel'),
  }

--[[
  2025-04-23
  2025-04-26
  2025-04-28
]]
