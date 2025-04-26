-- .SetPixel() alternative with color quantization

-- Last mod.: 2025-04-26

local Interface =
  {
    -- [Before]
    NumGradations = 6,

    -- [At]
    CreateExportFunc = request('CreateExportFunc'),

    -- [Internals]
    GranulateColor = request('GranulateColor'),
  }

-- Exports:
return Interface

--[[
  2025-04-26
]]
