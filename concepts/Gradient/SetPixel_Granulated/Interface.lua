-- .SetPixel() alternative with color quantization

-- Last mod.: 2025-05-06

local Interface =
  {
    -- [Before]
    NumGradations = 6,

    -- [At]
    Generate_SetPixel = request('Generate_SetPixel'),

    -- [Internals]
    NativeSetPixel = nil,
    GranulateColor = request('GranulateColor'),
    SetPixel = request('SetPixel'),
  }

-- Exports:
return Interface

--[[
  2025-04-26
  2025-05-06
]]
