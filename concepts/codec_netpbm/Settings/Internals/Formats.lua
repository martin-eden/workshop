-- Description of color and data encoding formats

--[[
  Author: Martin Eden
  Last mod.: 2026-08-08
]]

local Formats
do
  local monochrome_label
  local grayscale_label
  local color_label
  do
    local Syntels = request('^.^.Syntels')
    monochrome_label = Syntels.monochrome_label
    grayscale_label = Syntels.grayscale_label
    color_label = Syntels.color_label
  end

  Formats =
    {
      {
        label = monochrome_label,
        Settings = { num_channels = 1, num_channel_values = 2 },
      },
      {
        label = grayscale_label,
        Settings = { num_channels = 1 },
      },
      {
        label = color_label,
        Settings = { num_channels = 3 },
      },
    }
end

-- Export:
return Formats

--[[
  2025 # #
  2026 # #
  2026-06-04
  2026-06-15
]]
