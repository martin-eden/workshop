-- Linear 1-d gradient generator interface

--[[
  Author: Martin Eden
  Last mod.: 2025-04-06
]]

-- Exports:
return
  {
    -- [Before]
    ColorFormat = 'Gs',
    StartColor = nil,
    EndColor = nil,
    LineLength = 30,

    -- [At]
    Run = request('Run'),

    -- [After]
    Line = {},

    -- [Internals]
    BaseColor = nil,
    GetColor = request('GetColor'),
    SetColor = request('SetColor'),
  }

--[[
  2025-04-05
  2025-04-06
]]
