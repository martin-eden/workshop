-- 2-d pixels image settings

--[[
  Author: Martin Eden
  Last mod.: 2025-04-05
]]

--[[
  That's info that can be derived from actual image data.
  We provide <Width> and <Height> for convenience and
  pixel format (number of color components).

  Also we export table with possible values for pixel format
  for discoverability.
]]

-- Exports:
return
  {
    Width = 0,
    Height = 0,

    ColorFormats = { 'bw', 'gs', 'rgb' },
    ColorFormat = 'rgb',
  }

--[[
  2025-03-30
  2025-04-05
]]
