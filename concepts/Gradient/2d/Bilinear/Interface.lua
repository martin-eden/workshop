-- 2-d gradient generation

--[[
  Author: Martin Eden
  Last mod.: 2025-04-16
]]

-- Exports:
return
  {
    -- [Before]
    ColorFormat = 'Gs',

    ImageWidth = 5,
    ImageHeight = 5,

    StartingColors =
      {
        Left =
          {
            Top = nil,
            Bottom = nil,
          },
        Right =
          {
            Top = nil,
            Bottom = nil,
          },
      },

    -- [At]
    Run = request('Run'),

    -- [After]
    Image = {},

    -- [Internals]
    BaseColor = request('!.concepts.Image.Color.Grayscale'),
    LinearGenerator = request('!.concepts.Gradient.1d.Linear.Interface'),

    Init = request('Init'),
    Generate = request('Generate'),

    SetPixel = request('SetPixel'),
    GetPixel = request('GetPixel'),
  }

--[[
  2025-04-15
  2025-04-16
]]
