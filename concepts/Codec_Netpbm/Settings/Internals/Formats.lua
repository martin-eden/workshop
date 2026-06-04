-- Description of color and data encoding formats

--[[
  Author: Martin Eden
  Last mod.: 2026-06-04
]]

local Formats =
  {
    {
      label = 'P1',
      Settings = { num_channels = 1, num_channel_values = 2 },
      comment = 'Monochrome, text',
    },
    {
      label = 'P2',
      Settings = { num_channels = 1 },
      comment = 'Grayscale, text',
    },
    {
      label = 'P3',
      Settings = { num_channels = 3 },
      comment = 'Color, text',
    },
  }

-- Export:
return Formats

--[[
  2025 # #
  2026-01-25
  2026-05-31
  2026-06-04
]]
