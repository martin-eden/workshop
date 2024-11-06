-- Compile named Lua table to anonymous structure (list of strings/lists)

-- Last mod.: 2024-11-06

-- Exports:
return
  {
    -- Main: Convert table with .ppm to anonymous tree
    Run = request('Run'),

    -- [Config]

    -- Dimension (width and height) serialization format
    DimensionFmt = '%d',

    -- Color component serialization format
    ColorComponentFmt = '%03d',

    -- [Internal]

    -- Format constants
    Constants = request('^.Constants.Interface'),

    -- Compile header
    CompileHeader = request('CompileHeader'),

    -- Compile data
    CompileData = request('CompileData'),

    -- Compile pixel
    CompilePixel = request('CompilePixel'),

    -- Serialize color component
    CompileColorComponent = request('CompileColorComponent'),
  }

--[[
  2024-11-03
  2024-11-04
  2024-11-06
]]
