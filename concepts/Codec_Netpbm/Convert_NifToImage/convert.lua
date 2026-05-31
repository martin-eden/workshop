-- Convert table with PBM image to our internal image format

--[[
  Author: Martin Eden
  Last mod.: 2026-05-31
]]

--[[
  Custom Lua format

  Example:

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

-- Imports:
local ImageClass = request('!.concepts.Image.Interface')
local create_color = request('!.concepts.Image.Color.SpawnColor')
local normalize_color = request('!.concepts.Image.Color.Normalize')

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

local get_image_color =
  function(color_format, NifColor)
    local ImageColor = create_color(color_format)
    for i in ipairs(ImageColor) do
      ImageColor[i] = NifColor[i]
    end
    normalize_color(ImageColor)

    return ImageColor
  end

local convert_pixels =
  function(Image, ImageSettings, ImageNif)
    local width = ImageSettings.width
    local height = ImageSettings.height
    local num_channels = ImageSettings.num_channels
    local color_format = Image.Settings.ColorFormat

    for y, Row in ipairs(ImageNif) do
      for x, NifColor in ipairs(Row) do
        Image:SetPixel({ y, x }, get_image_color(color_format, NifColor))
      end
    end

    return Image
  end

local convert =
  function(ImageSettings, ImageNif)
    local Image = new(ImageClass)

    Image.Settings.Width = ImageSettings.width
    Image.Settings.Height = ImageSettings.height
    Image.Settings.ColorFormat =
      get_color_format(
        ImageSettings.num_channels,
        ImageSettings.num_channel_values
      )

    convert_pixels(Image, ImageSettings, ImageNif)

    return Image
  end

-- Export:
return convert

--[[
  2024 # # #
  2025 #
  2026-01-15
  2026-05-31
]]
