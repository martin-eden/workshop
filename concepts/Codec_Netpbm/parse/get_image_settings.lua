-- Return Netpbm image settings for given input stream with Netpbm header

--[[
  Author: Martin Eden
  Last mod.: 2026-06-05
]]

-- Imports:
local get_next_item = request('get_next_item')
local get_format_settings = request('^.Settings.get_format_settings')
local is_natural = request('!.number.is_natural')
local number_in_range = request('!.number.in_range')

local get_image_settings =
  function(Input)
    local label_str = get_next_item(Input)

    local FormatSettings = get_format_settings(label_str)

    local width = tonumber(get_next_item(Input))
    assert(is_natural(width))

    local height = tonumber(get_next_item(Input))
    assert(is_natural(height))

    local num_channel_values
    if is_nil(FormatSettings.num_channel_values) then
      local max_channel_value = tonumber(get_next_item(Input))
      local max_channel_value_min = 1
      local max_channel_value_max = 64 * 1024 - 1

      assert(
        number_in_range(
          max_channel_value,
          max_channel_value_min,
          max_channel_value_max
        )
      )

      num_channel_values = max_channel_value + 1
    else
      num_channel_values = FormatSettings.num_channel_values
    end

    return
      {
        width = width,
        height = height,
        num_channels = FormatSettings.num_channels,
        num_channel_values = num_channel_values,
      }
  end

-- Export:
return get_image_settings

--[[
  2026-06-05
]]
