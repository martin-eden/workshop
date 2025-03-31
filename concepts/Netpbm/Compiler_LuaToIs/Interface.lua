-- Compile named Lua table to anonymous structure (list of strings/lists)

-- Last mod.: 2025-03-31

-- Exports:
return
  {
    -- [Config]

    -- Image format settings
    Settings = request('^.Settings.Interface'),

    -- Color component serialization format
    ColorComponentFmt = '%03d',

    -- [Main]

    -- Convert table with image to anonymous tree
    Run = request('Run'),

    -- [Internals]

    -- Compile color
    CompileColor = request('CompileColor'),

    -- Serialize color component
    CompileColorComponent = request('CompileColorComponent'),
  }

--[[
  2024-11 # # # #
  2024-12 #
  2025-03-28
  2025-03-31
]]
