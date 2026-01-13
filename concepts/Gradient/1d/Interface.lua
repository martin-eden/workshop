-- Linear 1-d gradient generator interface

--[[
  Author: Martin Eden
  Last mod.: 2026-01-13
]]

-- Exports:
return
  {
    -- [In]
    ColorFormat = 'Gs',
    LineLength = 30,

    LeftColor = nil,
    RightColor = nil,

    -- [Run]
    Run = request('Run'),

    -- [Out]
    Line = {},

    -- [Internals]
    BaseColor = nil,

    Init = request('Init'),
    SetPixel = request('SetPixel'),
    GetPixel = request('GetPixel'),
    CreatePixel = request('CreatePixel'),
    CreateExecutionPlan = request('Alternatives.CreateExecutionPlan.Independent'),
    ExecutePlan = request('ExecutePlan'),
  }

--[[
  2024 # # #
  2025 # # # # # # # #
  2026 #
]]
