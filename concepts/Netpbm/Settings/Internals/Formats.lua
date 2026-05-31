-- Description of color and data encoding formats

--[[
  Author: Martin Eden
  Last mod.: 2026-05-31
]]

local Formats =
  {
    {
      label = 'P1',
      Settings = { num_channels = 1, is_text_storage = true, num_channel_values = 2 },
      comment = 'Monochrome, text',
    },
    {
      label = 'P2',
      Settings = { num_channels = 1, is_text_storage = true },
      comment = 'Grayscale, text',
    },
    {
      label = 'P3',
      Settings = { num_channels = 3, is_text_storage = true },
      comment = 'Color, text',
    },
    {
      label = 'P4',
      Settings = { num_channels = 1, is_text_storage = false, num_channel_values = 2 },
      comment = 'Monochrome, binary',
    },
    {
      label = 'P5',
      Settings = { num_channels = 1, is_text_storage = false },
      comment = 'Grayscale, binary',
    },
    {
      label = 'P6',
      Settings = { num_channels = 3, is_text_storage = false },
      comment = 'Color, binary',
    },
  }

-- Export:
return Formats

--[[
  2025 # #
  2026-01-25
  2026-05-31
]]
