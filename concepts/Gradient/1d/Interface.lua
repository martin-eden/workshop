-- Linear 1-d gradient generator interface

--[[
  Author: Martin Eden
  Last mod.: 2025-04-28
]]

-- Exports:
return
  {
    -- [Before]
    ColorFormat = 'Gs',
    LineLength = 30,

    LeftColor = nil,
    RightColor = nil,

    -- [At]
    Run = request('Run'),

    -- [After]
    Line = {},

    -- [Internals]
    BaseColor = nil,

    Init = request('Init'),
    Generate = request('Generate'),
    SetPixel = request('SetPixel'),
    GetPixel = request('GetPixel'),
    CreatePixel = request('CreatePixel'),
    CreateExecutionPlan = request('Alternatives.CreateExecutionPlan.Independent'),
  }

--[[
  2024-09 #
  2024-11 # #
  2025-03 #
  2025-04-05
  2025-04-06
  2025-04-15
  2025-04-16
  2025-04-23
  2025-04-26
  2025-04-28
]]
