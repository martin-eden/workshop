-- Linear 1-d gradient generator interface

--[[
  Author: Martin Eden
  Last mod.: 2025-04-16
]]

-- Exports:
return
  {
    -- [Before]
    ColorFormat = 'Gs',
    LineLength = 30,

    StartColor = nil,
    EndColor = nil,

    -- [At]
    Run = request('Run'),

    -- [After]
    Line = {},

    -- [Internals]
    BaseColor = nil,

    Init = request('Init'),
    SetPixel = request('SetPixel'),
  }

--[[
  2024-09 #
  2024-11 # #
  2025-03 #
  2025-04-05
  2025-04-06
  2025-04-15
  2025-04-16
]]
