-- Serialize to pixmap format

-- Last mod.: 2025-04-09

-- Exports:
return
  {
    -- [Config]
    Output = request('!.concepts.StreamIo.Output'),

    -- [Main]
    Run = request('Run'),

    -- [Internals]
    Settings = request('^.Settings.Interface'),

    WriteLine = request('WriteLine'),
    WriteHeader = request('WriteHeader'),
    CompileColor = request('CompileColor'),
    WriteData = request('WriteData'),
  }

--[[
  2024-11 # #
  2025-03-28
  2025-04-09
]]
