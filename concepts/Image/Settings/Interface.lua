-- 2-d pixels image settings

--[[
  Author: Martin Eden
  Last mod.: 2025-03-30
]]

--[[
  That's info that can be derived from actual image data.
  We provide <Width> and <Height> for convenience and
  pixel format (number of color components).

  Also we export table with possible values for pixel format
  for discoverability.
]]

local ColorFormats =
  {
    Bw = 'bw',
    Grayscale = 'gs',
    Rgb = 'rgb',
  }

-- Exports:
return
  {
    Width = 0,
    Height = 0,

    ColorFormats = ColorFormats,
    ColorFormat = ColorFormats.Rgb,
  }

--[[
  2025-03-30
]]
