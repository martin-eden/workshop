-- 2-d "plasm" generation

--[[
  Author: Martin Eden
  Last mod.: 2025-04-11
]]

-- Exports:
return
  {
    -- [Before]
    ImageWidth = 5,
    ImageHeight = 5,
    BaseColor = request('!.concepts.Image.Color.Grayscale'),

    -- [At]
    -- Generate
    Run = request('Run'),

    -- [After]
    -- Resulting 2-d image
    Image = {},

    -- [Internals]
    MaxDistance = 0.0,
    PrintPoint = request('PrintPoint'),
    IsValidCoord = request('IsValidCoord'),
    SetColor = request('SetColor'),
    GetColor = request('GetColor'),
    Plasm = request('Plasm'),
    CalcDistance = request('CalcDistance'),
    ObservePoint = request('ObservePoint'),
    GetDistanceNoise = request('GetDistanceNoise'),
    SpawnPoint = request('SpawnPoint'),
    CalculateMidwayPixel = request('CalculateMidwayPixel'),
    CalculateSidePixel = request('CalculateSidePixel'),
  }

--[[
  2025-04-04
  2025-04-11
]]
