-- Parse from anonymous structure to custom Lua format

-- Last mod.: 2024-11-25

-- Exports:
return
  {
    -- [Main] Parse pixmap structure to Lua table in custom format
    Run = request('Run'),

    -- [Internal]

    -- .ppm format constants
    Constants = request('^.Constants.Interface'),

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
]]
