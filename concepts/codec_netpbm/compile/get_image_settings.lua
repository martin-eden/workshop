-- Return Netpbm image settings for given internal image

--[[
  Author: Martin Eden
  Last mod.: 2026-06-04
]]

-- Returns <num_channels>, <max_channel_value>
local get_channel_settings =
  function(color_format)
    if (color_format == 'bw') then
      return 1, 1
    elseif (color_format == 'gs') then
      return 1, 255
    elseif (color_format == 'rgb') then
      return 3, 255
    end

    error('Unknown color format.')
  end

local get_image_settings =
  function(Image)
    local width = Image.Settings.Width
    local height = Image.Settings.Height
    local color_format = Image.Settings.ColorFormat

    local num_channels, max_channel_value =
      get_channel_settings(color_format)

    return
      {
        width = width,
        height = height,
        num_channels = num_channels,
        max_channel_value = max_channel_value,
      }
  end

-- Export:
return get_image_settings

--[[
  2026-06-04
]]
