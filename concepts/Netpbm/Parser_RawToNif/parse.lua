-- Load image data and image settings

--[[
  Author: Martin Eden
  Last mod.: 2026-05-31
]]

--[[
  Example:

    'P3 1 2 255 0 128 255 128 255 0'
                  ->
    {
      width = 1,
      height = 2,
      num_channels = 3,
      num_channel_values = 256,
      is_text_storage = true,
    },
    {
      [1] = { [1] = { 0, 128, 255 } },
      [2] = { [1] = { 128, 255, 0 } },
    }
]]

-- Imports:
local get_next_item = request('Internals.get_next_item')
local get_format_settings = request('^.Settings.get_format_settings')
local is_natural = request('!.number.is_natural')
local number_in_range = request('!.number.in_range')
local get_image = request('Internals.get_image')

--[[
  Convert from pixmap to itness

  Returns nil if problems.
]]
local parse =
  function(Input)
    local label_str = get_next_item(Input)

    local FormatSettings = get_format_settings(label_str)

    local width_str = get_next_item(Input)
    local width = tonumber(width_str)
    assert(is_natural(width))

    local height_str = get_next_item(Input)
    local height = tonumber(height_str)
    assert(is_natural(height))

    local num_channel_values
    if is_nil(FormatSettings.num_channel_values) then
      local max_channel_value_str = get_next_item(Input)
      local max_channel_value = tonumber(max_channel_value_str)
      assert(number_in_range(max_channel_value, 0, 64 * 1024 - 1))

      num_channel_values = max_channel_value + 1
    else
      num_channel_values = FormatSettings.num_channel_values
    end

    local ImageSettings =
      {
        width = width,
        height = height,
        num_channels = FormatSettings.num_channels,
        num_channel_values = num_channel_values,
        is_text_storage = FormatSettings.is_text_storage,
      }

    return ImageSettings, get_image(Input, ImageSettings)
  end

-- Export:
return parse

--[[
  2024 # # #
  2025 # #
  2026-05-31
]]
