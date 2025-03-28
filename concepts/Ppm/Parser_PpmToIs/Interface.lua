-- Load pixmap to itness format (list with strings and lists)

-- Last mod.: 2025-03-28

-- Exports:
return
  {
    -- [Config]
    -- Input stream
    Input = request('!.concepts.StreamIo.Input'),

    NumColorComponents = 3,

    -- [Main]
    -- Load pixmap to itness format
    Run = request('Run'),

    -- [Internal]
    ItemGetter = request('ItemGetter.Interface'),
    ParseHeader = request('ParseHeader'),
    GetPixels = request('GetPixels'),
  }

--[[
  2024-11-02
  2024-11-03
  2024-11-06
  2025-03-28
]]
