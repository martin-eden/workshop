-- Parse from anonymous structure to custom Lua format

-- Last mod.: 2025-03-31

-- Exports:
return
  {
    -- [Config]
    Settings = request('^.Settings.Interface'),

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
  2024-11 # #
  2025-03-28
  2025-03-31
]]
