-- 2-d gradient generation

--[[
  Author: Martin Eden
  Last mod.: 2025-04-15
]]

-- Exports:
return
  {
    -- [Before]
    ImageWidth = 5,
    ImageHeight = 5,
    ColorFormat = 'Gs',
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
    -- Generate
    Run = request('Run'),

    -- [After]
    -- Resulting 2-d image
    Image = {},

    -- [Internals]
    BaseColor = request('!.concepts.Image.Color.Grayscale'),
    Generate = request('Generate'),

    IsValidCoord = request('IsValidCoord'),
    SetColor = request('SetColor'),
    GetColor = request('GetColor'),
  }

--[[
  2025-04-15
]]
