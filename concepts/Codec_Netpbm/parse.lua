-- Parse image from PBM format

--[[
  Author: Martin Eden
  Last mod.: 2026-06-05
]]

--[[
  Example:

    'P3 1 2 255 0 128 255 128 255 0'
                  ->
    {
      Settings =
        {
          Width = 1,
          Height = 2,
          ColorFormat = 'rgb',
        },
      Data =
        {
          [1] = { [1] = { 0.0, 0.5, 1.0 } },
          [2] = { [1] = { 0.5, 1.0, 0.0 } },
        },
    }
]]

-- ( Imports
local get_next_item = request('parse.get_next_item')
local get_image_settings = request('parse.get_image_settings')

local number_in_range = request('!.number.in_range')
local create_color = request('!.concepts.Image.Color.SpawnColor')
local normalize_color = request('!.concepts.Image.Color.Normalize')
local ImageClass = request('!.concepts.Image.Interface')
-- )

local get_color_component =
  function(item_str, max_color_value)
    local value = tonumber(item_str)

    assert_integer(value)
    assert(number_in_range(value, 0, max_color_value))

    return value
  end

local load_image =
  function(Image, ImageSettings, Input)
    local width = ImageSettings.width
    local height = ImageSettings.height
    local num_channels = ImageSettings.num_channels
    local max_color_value = ImageSettings.num_channel_values - 1

    local color_format = Image.Settings.ColorFormat

    for y = 1, height do
      for x = 1, width do
        local ImageColor = create_color(color_format)

        for channel = 1, num_channels do
          local item_str = get_next_item(Input)
          local channel_value = get_color_component(item_str, max_color_value)
          ImageColor[channel] = channel_value
        end

        normalize_color(ImageColor)

        Image:SetPixel({ y, x }, ImageColor)
      end
    end
  end

local get_color_format =
  function(num_channels, num_channel_values)
    if (num_channels == 1) then
      if (num_channel_values == 2) then
        return 'bw'
      end
      return 'gs'
    elseif (num_channels == 3) then
      return 'rgb'
    end
    error('Failed to determine internal image format.')
  end

local parse =
  function(Input)
    local Image = new(ImageClass)

    local ImageSettings = get_image_settings(Input)

    Image.Settings.Width = ImageSettings.width
    Image.Settings.Height = ImageSettings.height
    Image.Settings.ColorFormat =
      get_color_format(
        ImageSettings.num_channels,
        ImageSettings.num_channel_values
      )

    load_image(Image, ImageSettings, Input)

    return Image
  end

-- Export:
return parse

--[[
  2024
  2026-05-31
  2026-06-05
]]
