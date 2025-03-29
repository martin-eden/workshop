-- Compile named Lua table to anonymous structure (list of strings/lists)

-- Last mod.: 2025-03-28

-- Exports:
return
  {
    -- Main: Convert table with .ppm to anonymous tree
    Run = request('Run'),

    -- [Config]

    -- Color component serialization format
    ColorComponentFmt = '%03d',

    -- [Internal]

    -- Compile image data
    CompileImage = request('CompileImage'),

    -- Compile color
    CompileColor = request('CompileColor'),

    -- Serialize color component
    CompileColorComponent = request('CompileColorComponent'),
  }

--[[
  2024-11 # # # #
  2024-12 #
  2025-03-28
]]
