-- Parse from anonymous structure to custom Lua format

-- Last mod.: 2025-03-28

-- Exports:
return
  {
    -- [Config]
    BaseColor = request('!.concepts.Image.Color.Rgb'),

    -- [Main] Parse pixmap structure to Lua table in custom format
    Run = request('Run'),

    -- [Internal]

    -- Parse raw pixels data
    ParsePixels = request('ParsePixels'),

    -- Parse pixel
    ParsePixel = request('ParsePixel'),

    -- Parse color component value
    ParseColorComponent = request('ParseColorComponent'),
  }

--[[
  2024-11-02
  2024-11-06
  2025-03-28
]]
