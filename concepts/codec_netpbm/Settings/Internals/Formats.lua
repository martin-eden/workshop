-- Description of color and data encoding formats

--[[
  Author: Martin Eden
  Last mod.: 2026-06-15
]]

local Formats =
  {
    {
      label = 'P1',
      Settings = { num_channels = 1, num_channel_values = 2 },
    },
    {
      label = 'P2',
      Settings = { num_channels = 1 },
    },
    {
      label = 'P3',
      Settings = { num_channels = 3 },
    },
  }

-- Export:
return Formats

--[[
  2025 # #
  2026 # #
  2026-06-04
  2026-06-15
]]
