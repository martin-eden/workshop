-- Export CreatePixel() function that introduces distance noise

-- Last mod.: 2025-04-23

-- Exports:
return
  {
    -- [Before]
    Scale = 1.0,
    GetDistanceNoiseAmplitude = request('GetDistanceNoiseAmplitude'),

    -- [At]
    GenerateExportFunction = request('GenerateExportFunction'),

    -- [Internals]
    MakeDistanceNoise = request('MakeDistanceNoise'),
    ObservePixel = request('ObservePixel'),
  }

--[[
  2025-04-23
]]
