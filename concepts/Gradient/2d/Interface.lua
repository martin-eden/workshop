-- 2-d gradient generation

--[[
  Author: Martin Eden
  Last mod.: 2025-05-04
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
        LeftTop = nil,
        RightTop = nil,
        LeftBottom = nil,
        RightBottom = nil,
      },

    -- [At]
    Run = request('Run'),

    -- [After]
    Image = {},

    -- [Internals]
    BaseColor = nil,
    LinearGenerator = request('!.concepts.Gradient.1d.Interface'),

    Init = request('Init'),
    Generate = request('Generate'),

    SetPixel = request('SetPixel'),
    GetPixel = request('GetPixel'),

    CreateExecutionPlan = request('CreateExecutionPlan'),

    HStroke = request('HStroke'),
    VStroke = request('VStroke'),
  }

--[[
  2025-04 # # # #
  2025-05-04
]]
