-- Serialize image data and image settings to PBM format

--[[
  Author: Martin Eden
  Last mod.: 2026-06-03
]]

--[[
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
    P3  # Color, text
    1 2 255  # Width, Height, MaxValue

    # Line 1
    000 128 255

    # Line 2
    128 255 000
]]

-- Imports:
local get_format_label = request('^.Settings.get_format_label')
local get_format_comment = request('^.Settings.get_format_comment')
local add_to_list = request('!.concepts.list.add_item')
local list_to_string = request('!.concepts.list.to_string')
local write_line = request('Internals.write_line')

local write_header =
  function(Output, ImageSettings)
    local format_label = get_format_label(ImageSettings)
    local format_comment = get_format_comment(format_label)

    write_line(Output, format_label, format_comment)

    local width = ImageSettings.width
    local height = ImageSettings.height
    local max_color_value = ImageSettings.num_channel_values - 1

    local dims_str = string.format('%s %s %s', width, height, max_color_value)
    local dims_comment = 'Width, Height, MaxValue'

    write_line(Output, dims_str, dims_comment)
  end

local write_data =
  function(Output, ImageSettings, ImageNif)
    assert(ImageSettings.is_text_storage)

    local num_channels = ImageSettings.num_channels
    local width = ImageSettings.width
    local height = ImageSettings.height

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

      write_line(Output, '')

      write_line(Output, '', string.format('Line %d', y))

      for x = 1, width do
        local Color = { }

        for color_component_num = 1, num_channels do
          local color_component = ImageNif[y][x][color_component_num]

          add_to_list(Color, string.format(color_component_fmt, color_component))
        end

        add_to_list(Line, list_to_string(Color, components_delim))

        if (x % num_colors_per_data_line == 0) then
          write_line(Output, list_to_string(Line, columns_delim))
          Line = { }
        end
      end

      -- Write remained chunk
      if (width % num_colors_per_data_line ~= 0) then
        write_line(Output, list_to_string(Line, columns_delim))
      end
    end
  end

local compile =
  function(Output, ImageSettings, ImageNif)
    write_header(Output, ImageSettings)
    write_data(Output, ImageSettings, ImageNif)
  end

-- Exports:
return compile

--[[
  2024 # # # #
  2025 # #
  2026-05-31
  2026-06-06
]]
