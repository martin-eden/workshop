-- 2-d gradient generation

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

-- Imports:
local BaseInterface = request('^.Interface')
local Merge = request('!.table.merge')

local Interface =
  {
    -- [In]
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

    -- [Run]
    Run = request('Run'),

    -- [Internals]
    BaseColor = nil,

    Init = request('Init'),

    CreateExecutionPlan = request('CreateExecutionPlan'),
  }

Merge(Interface, BaseInterface)

-- Exports:
return Interface

--[[
  2025 # # # # #
  2026 #
  2026-01-14
]]
