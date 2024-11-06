-- Encode/decode .ppm file to Lua table

-- Last mod.: 2024-11-06

-- Exports:
return
  {
    -- [Config]

    -- Input stream
    Input = request('!.concepts.StreamIo.Input'),

    -- Output stream
    Output = request('!.concepts.StreamIo.Output'),

    -- [Main]

    -- Load image from stream
    Load = request('Load'),

    -- Save image to stream
    Save = request('Save'),
  }

--[[
  2024-11-04
]]
