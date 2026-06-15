-- Compile image to PBM format

--[[
  Author: Martin Eden
  Last mod.: 2026-06-15
]]

--[[
  Example:

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
                  ->
    P3  # Color, text
    1 2 255  # Width, Height, MaxValue

    # Line 1
    000 128 255

    # Line 2
    128 255 000
]]

-- ( Imports
local get_image_settings = request('compile.get_image_settings')
local Serializer = request('compile.Serializer')
local get_format_comment = request('compile.get_format_comment')

local get_format_label = request('Settings.get_format_label')

local create_color = request('!.concepts.Image.Color.SpawnColor')
local denormalize_color = request('!.concepts.Image.Color.Denormalize')
local number_in_range = request('!.number.in_range')
local add_to_list = request('!.concepts.list.add_item')
local list_to_string = request('!.concepts.list.to_string')
-- )

local write_header =
  function(ImageSettings, Serializer)
    local format_label = get_format_label(ImageSettings)
    local format_comment = get_format_comment(format_label)

    Serializer:WriteData(format_label)
    Serializer:WriteComment(format_comment)

    local width = ImageSettings.width
    local height = ImageSettings.height
    local max_channel_value = ImageSettings.max_channel_value

    local dims_comment = 'Width Height MaxValue'

    Serializer:WriteData(width)
    Serializer:WriteData(height)
    Serializer:WriteData(max_channel_value)
    Serializer:WriteComment(dims_comment)
  end

local convert_color =
  function(Color, max_channel_value)
    denormalize_color(Color)

    for _, color_component in ipairs(Color) do
      assert(number_in_range(color_component, 0, max_channel_value))
    end
  end

local write_data =
  function(ImageSettings, Image, Serializer)
    local width = ImageSettings.width
    local height = ImageSettings.height
    local num_channels = ImageSettings.num_channels
    local max_channel_value = ImageSettings.max_channel_value

    local color_format = Image.Settings.ColorFormat

    local num_colors_per_data_line

    if (num_channels == 1) then
      num_colors_per_data_line = 12
    elseif (num_channels == 3) then
      num_colors_per_data_line = 4
    else
      error('Unsupported number of color channels.')
    end

    local line_comment_fmt = 'Line %d'
    local columns_delim = '  '
    local color_component_fmt = '%03d'

    for y = 1, height do
      Serializer:WriteNewline()

      local line_comment = string.format(line_comment_fmt, y)
      Serializer:WriteComment(line_comment)

      local is_first_item_in_line = true

      for x = 1, width do
        if not is_first_item_in_line then
          Serializer:WriteRaw(columns_delim)
        end

        local ImageColor = Image:GetPixel({ y, x })
        if is_nil(ImageColor) then
          ImageColor = create_color(color_format)
        end

        local PbmColor = new(ImageColor)
        convert_color(PbmColor, max_channel_value)

        for channel = 1, num_channels do
          local color_component_str =
            string.format(color_component_fmt, PbmColor[channel])
          Serializer:WriteData(color_component_str)
        end

        is_first_item_in_line = false

        if (x % num_colors_per_data_line == 0) then
          Serializer:WriteNewline()
          is_first_item_in_line = true
        end
      end

      if (width % num_colors_per_data_line ~= 0) then
        Serializer:WriteNewline()
      end
    end
  end

local compile =
  function(Image, Output)
    local EncoderImageSettings = get_image_settings(Image)

    local Serializer = new(Serializer)
    Serializer.Output = Output

    write_header(EncoderImageSettings, Serializer)
    write_data(EncoderImageSettings, Image, Serializer)
  end

-- Exports:
return compile

--[[
  2024 # # # #
  2025 # #
  2026-01 #
  2026-05 #
  2026-06-04
  2026-06-15
]]
