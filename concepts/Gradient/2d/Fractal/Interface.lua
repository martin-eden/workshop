-- 2-d "plasm" generation

--[[
  Author: Martin Eden
  Last mod.: 2025-04-04
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
    SetPixel = request('SetPixel'),
    Plasm = request('Plasm'),
    CalculateMidwayPixel = request('CalculateMidwayPixel'),
    CalculateSidePixel = request('CalculateSidePixel'),
  }

--[[
  2025-04-04
]]
