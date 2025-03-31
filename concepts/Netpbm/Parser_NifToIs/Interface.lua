-- Load pixmap to itness format (list with strings and lists)

-- Last mod.: 2025-03-31

-- Exports:
return
  {
    -- [Config]

    -- File format
    Settings = request('^.Settings.Interface'),

    -- Input stream
    Input = request('!.concepts.StreamIo.Input'),

    -- [Main]
    -- Load pixmap to itness format
    Run = request('Run'),

    -- [Internal]
    ItemGetter = request('ItemGetter.Interface'),
    ParseHeader = request('ParseHeader'),
    GetPixels = request('GetPixels'),
  }

--[[
  2024-11 # # #
  2025-03-28
  2025-03-31
]]
