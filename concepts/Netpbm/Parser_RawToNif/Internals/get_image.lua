-- Load raw pixels data from .ppm stream

--[[
  Author: Martin Eden
  Last mod.: 2026-05-31
]]

-- Imports:
local get_next_item = request('get_next_item')
local add_to_list = request('!.concepts.list.add_item')
local number_in_range = request('!.number.in_range')

local get_color_component =
  function(item_str, max_color_value)
    local value = tonumber(item_str)

    assert_integer(value)
    assert(number_in_range(value, 0, max_color_value))

    return value
  end

local get_image =
  function(Input, ImageSettings)
    local width = ImageSettings.width
    local height = ImageSettings.height
    local num_channels = ImageSettings.num_channels
    local max_color_value = ImageSettings.num_channel_values - 1

    local Image = { }
    for _ = 1, height do
      local Row = { }
      for _ = 1, width do
        local Color = { }
        for _ = 1, num_channels do
          add_to_list(
            Color,
            get_color_component(get_next_item(Input), max_color_value)
          )
        end
        add_to_list(Row, Color)
      end
      add_to_list(Image, Row)
    end

    return Image
  end

-- Exports:
return get_image

--[[
  2024 #
  2025 #
  2026-05-31
]]
