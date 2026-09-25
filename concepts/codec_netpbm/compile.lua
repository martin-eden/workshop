-- Serialize

--[[
  Author: Martin Eden
  Last mod.: 2026-09-26
]]

local Serializer = request('compile.Serializer')

local write_header
do
  local get_format_label
  local get_format_comment
  do
    local Syntels = request('Syntels')
    local ExtToInt_Map =
      {
        [1] = Syntels.monochrome_label,
        [2] = Syntels.grayscale_label,
        [3] = Syntels.color_label,
      }
    local FormatComments =
      {
        [1] = 'Monochrome image, text format',
        [2] = 'Grayscale image, text format',
        [3] = 'Color image, text format',
      }

    get_format_label =
      function(format)
        local label = ExtToInt_Map[format]
        assert(label, 'Unknown internal format.')
        return label
      end

    get_format_comment =
      function(format)
        local comment = FormatComments[format]
        assert(comment, 'Unknown internal format.')
        return comment
      end
  end

  write_header =
    function(Pbm, Serializer)
      local format = Pbm:GetFormat()
      local Image = Pbm:GetImage()

      local width = Image:GetWidth()
      local height = Image:GetHeight()

      local format_label = get_format_label(format)
      local format_comment = get_format_comment(format)

      Serializer:WriteData(format_label)
      Serializer:WriteComment(format_comment)

      if (format == 1) then
        local dims_comment = 'Width Height'
        Serializer:WriteData(width)
        Serializer:WriteData(height)
        Serializer:WriteComment(dims_comment)
      elseif (format == 2) or (format == 3) then
        local max_channel_value = 255
        local dims_comment = 'Width Height MaxValue'
        Serializer:WriteData(width)
        Serializer:WriteData(height)
        Serializer:WriteData(max_channel_value)
        Serializer:WriteComment(dims_comment)
      end
    end
end

local write_data
do
  local denormalize_color = request('!.concepts.Image.Color.Denormalize')
  local str_format = string.format

  write_data =
    function(Pbm, Serializer)
      local format = Pbm:GetFormat()
      local Image = Pbm:GetImage()

      local width = Image:GetWidth()
      local height = Image:GetHeight()

      local num_channels
      local num_colors_per_data_line
      if (format == 1) or (format == 2) then
        num_channels = 1
        num_colors_per_data_line = 12
      elseif (format == 3) then
        num_channels = 3
        num_colors_per_data_line = 4
      end

      local color_component_fmt
      if (format == 1) then
        color_component_fmt = '%d'
      elseif (format == 2) or (format == 3) then
        color_component_fmt = '%03d'
      end

      local line_comment_fmt = 'Line %d'
      local columns_delim = '  '

      for y = 1, height do
        Serializer:WriteNewline()

        local line_comment = str_format(line_comment_fmt, y)
        Serializer:WriteComment(line_comment)

        local is_first_item_in_line = true

        for x = 1, width do
          if not is_first_item_in_line then
            Serializer:WriteRaw(columns_delim)
          end

          local Color = Image:GetColor(x, y)
          denormalize_color(Color)

          -- For bitmap max value is 1, not 255. Also white is 0
          if (format == 1) then
            for channel = 1, num_channels do
              Color[channel] = 1 - ((Color[channel] / 256 * 2) // 1)
            end
          end

          for channel = 1, num_channels do
            local color_component_str =
              str_format(color_component_fmt, Color[channel])
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
end

-- Export:
return
  function(Pbm, Output)
    local Serializer = new(Serializer)
    Serializer.Output = Output

    write_header(Pbm, Serializer)
    write_data(Pbm, Serializer)
  end

--[[
  2024 # # # #
  2025 # #
  2026 # # # #
  2026-09-25
]]
