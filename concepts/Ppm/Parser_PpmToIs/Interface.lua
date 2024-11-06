-- Load pixmap to itness format (list with strings and lists)

-- Last mod.: 2024-11-06

-- Exports:
return
  {
    -- [Config]

    -- Input stream
    Input = request('!.concepts.StreamIo.Input'),

    -- [Main] Load pixmap to itness format
    Run = request('Run'),

    -- [Internal]

    -- .ppm format constants
    Constants = request('^.Constants.Interface'),

    -- Next character. Used by GetNextCharacter()
    NextCharacter = nil,

    -- Get next character
    GetNextCharacter = request('GetNextCharacter'),

    -- Get next item
    GetNextItem = request('GetNextItem'),

    -- Get chunk of items
    GetChunk = request('GetChunk'),

    -- Parse header from raw data
    ParseHeader = request('ParseHeader'),

    -- Load raw pixels data from input stream
    GetPixels = request('GetPixels'),
  }

--[[
  2024-11-02
  2024-11-03
  2024-11-06
]]
