-- Encode/decode .ppm file to Lua table

-- Last mod.: 2025-03-29

local ColorFormats =
  {
    Bw = 'bw',
    Grayscale = 'grayscale',
    Rgb = 'rgb',
  }

local DataEncodings =
  {
    Binary = 'binary',
    Text = 'text',
  }

-- Exports:
return
  {
    -- [Config]
    ColorFormat = ColorFormats.Rgb,
    DataEncoding = DataEncodings.Text,

    Input = request('!.concepts.StreamIo.Input'),
    Output = request('!.concepts.StreamIo.Output'),

    -- [Main]
    Load = request('Load'),
    Save = request('Save'),

    -- [Internals]
    -- ( Discoverability
    ColorFormats = ColorFormats,
    DataEncodings = DataEncodings,
    -- )

  }

--[[
  2024-11-04
  2025-03-29
]]
