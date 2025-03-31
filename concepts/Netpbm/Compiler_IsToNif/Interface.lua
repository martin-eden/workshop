-- Serialize to pixmap format

-- Last mod.: 2025-03-29

-- Exports:
return
  {
    -- [Config]

    -- File format
    Settings = request('^.Settings.Interface'),

    -- Output stream
    Output = request('!.concepts.StreamIo.Output'),

    -- Format label format (lol)
    LabelFmt = '%s  # Plain portable pixmap',

    -- Header serialization format
    HeaderFmt = '%s %s %s  # Width, Height, Max color component value',

    -- Lines (rows) separator
    LinesDelimiter = '',

    -- Columns (pixels) separator
    ColumnsDelimiter = '  ',

    -- Number of serialized pixels per line of output
    NumColumns = 4,

    -- [Main]

    -- Serialize anonymous structure to pixmap
    Run = request('Run'),

    -- [Internal]

    -- Write label
    WriteLabel = request('WriteLabel'),

    -- Write header
    WriteHeader = request('WriteHeader'),

    -- Write data
    WriteData = request('WriteData'),

    -- Compile pixel to string
    CompilePixel = request('CompilePixel'),

    -- Write string as line to output
    WriteLine = request('WriteLine'),
  }

--[[
  2024-11-02
  2024-11-03
  2025-03-28
]]
