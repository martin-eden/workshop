-- Compile image to PBM format

--[[
  Author: Martin Eden
  Last mod.: 2026-06-05
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
local write_line = request('compile.write_line')

local get_format_label = request('Settings.get_format_label')
local get_format_comment = request('Settings.get_format_comment')

local create_color = request('!.concepts.Image.Color.SpawnColor')
local denormalize_color = request('!.concepts.Image.Color.Denormalize')
local number_in_range = request('!.number.in_range')
local add_to_list = request('!.concepts.list.add_item')
local list_to_string = request('!.concepts.list.to_string')
-- )

local write_header =
  function(ImageSettings, Output)
    local format_label = get_format_label(ImageSettings)
    local format_comment = get_format_comment(format_label)

    write_line(format_label, format_comment, Output)

    local width = ImageSettings.width
    local height = ImageSettings.height
    local max_channel_value = ImageSettings.max_channel_value

    local dims_str = string.format('%s %s %s', width, height, max_channel_value)
    local dims_comment = 'Width, Height, MaxValue'

    write_line(dims_str, dims_comment, Output)
  end

local convert_color =
  function(Color, max_channel_value)
    denormalize_color(Color)

    for _, color_component in ipairs(Color) do
      assert(number_in_range(color_component, 0, max_channel_value))
    end
  end

local write_data =
  function(ImageSettings, Image, Output)
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

    local columns_delim = '  '
    local components_delim = ' '
    local color_component_fmt = '%03d'

    for y = 1, height do
      local Line = { }

      write_line('', '', Output)

      write_line('', string.format('Line %d', y), Output)

      for x = 1, width do
        local ImageColor = Image:GetPixel({ y, x })
        if is_nil(ImageColor) then
          ImageColor = create_color(color_format)
        end

        local PbmColor = new(ImageColor)
        convert_color(PbmColor, max_channel_value)

        local StrColor = { }

        for _, color_component in ipairs(PbmColor) do
          add_to_list(StrColor, string.format(color_component_fmt, color_component))
        end

        add_to_list(Line, list_to_string(StrColor, components_delim))

        if (x % num_colors_per_data_line == 0) then
          write_line(list_to_string(Line, columns_delim), '', Output)
          Line = { }
        end
      end

      -- Write remained chunk
      if (width % num_colors_per_data_line ~= 0) then
        write_line(list_to_string(Line, columns_delim), '', Output)
      end
    end
  end

local compile =
  function(Image, Output)
    local EncoderImageSettings = get_image_settings(Image)

    write_header(EncoderImageSettings, Output)
    write_data(EncoderImageSettings, Image, Output)
  end

-- Exports:
return compile

--[[
  2024 # # # #
  2025 # #
  2026-01 #
  2026-05 #
  2026-06-04
]]
