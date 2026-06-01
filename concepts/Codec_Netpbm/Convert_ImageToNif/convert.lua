-- Convert our internal image format to table with PBM image

--[[
  Author: Martin Eden
  Last mod.: 2026-06-01
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
    {
      width = 1,
      height = 2,
      num_channels = 3,
      num_channel_values = 256,
    },
    {
      [1] = { [1] = { 0, 128, 255 } },
      [2] = { [1] = { 128, 255, 0 } },
    }

]]

-- Imports:
local create_color = request('!.concepts.Image.Color.SpawnColor')
local patch_table = request('!.table.patch')
local denormalize_color = request('!.concepts.Image.Color.Denormalize')
local number_in_range = request('!.number.in_range')
local add_to_list = request('!.concepts.list.add_item')

-- Returns <num_channels>, <num_channel_values>
local get_channel_settings =
  function(color_format)
    if (color_format == 'bw') then
      return 1, 2
    elseif (color_format == 'gs') then
      return 1, 256
    elseif (color_format == 'rgb') then
      return 3, 256
    end
    error('Unknown color format.')
  end

local get_nif_color =
  function(color_format, Color, max_color_value)
    -- <Color> can be nil

    local NifColor = create_color(color_format)
    patch_table(NifColor, Color)

    denormalize_color(NifColor)

    local Result = { }

    for _, color_component in ipairs(NifColor) do
      assert(number_in_range(color_component, 0, max_color_value))

      add_to_list(Result, string.format('%03d', color_component))
    end

    return Result
  end

local convert =
  function(Image)
    local width = Image.Settings.Width
    local height = Image.Settings.Height
    local color_format = Image.Settings.ColorFormat

    local num_channels, num_channel_values =
      get_channel_settings(color_format)
    local max_color_value = num_channel_values - 1

    local ImageSettings =
      {
        width = width,
        height = height,
        num_channels = num_channels,
        num_channel_values = num_channel_values,
      }

    local ImageNif = { }

    for y = 1, height do
      ImageNif[y] = { }
      for x = 1, width do
        ImageNif[y][x] =
          get_nif_color(
            color_format,
            Image:GetPixel({ y, x }),
            max_color_value
          )
      end
    end

    return ImageSettings, ImageNif
  end

-- Export:
return convert

--[[
  2024 # # # # #
  2025 # #
  2026-01-13
  2026-05-31
  2026-06-01
]]
