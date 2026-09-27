-- Serialize

--[[
  Author: Martin Eden
  Last mod.: 2026-09-27
]]

local write_header
do
  local get_format_label
  do
    local Syntels = request('Syntels')
    local IntToExt_Map =
      {
        [1] = Syntels.monochrome_label,
        [2] = Syntels.grayscale_label,
        [3] = Syntels.color_label,
      }
    get_format_label =
      function(format)
        local label = IntToExt_Map[format]
        assert(label, 'Unknown internal format.')
        return label
      end
  end

  local get_format_comment
  do
    local FormatComments =
      {
        [1] = 'Monochrome image, text format',
        [2] = 'Grayscale image, text format',
        [3] = 'Color image, text format',
      }
    get_format_comment =
      function(format)
        local comment = FormatComments[format]
        assert(comment, 'Unknown internal format.')
        return comment
      end
  end

  write_header =
    function(Pam, Write)
      local format = Pam:GetFormat()
      local Image = Pam:GetImage()

      local width = Image:GetWidth()
      local height = Image:GetHeight()

      Write:Data(get_format_label(format))
      Write:Comment(get_format_comment(format))

      if (format == 1) then
        Write:Data(tostring(width))
        Write:Data(tostring(height))
        Write:Comment('Width Height')
      elseif (format == 2) or (format == 3) then
        Write:Data(tostring(width))
        Write:Data(tostring(height))
        Write:Data('255')
        Write:Comment('Width Height MaxValue')
      end
    end
end

local write_data
do
  local denormalize_color = request('!.concepts.Image.Color.Denormalize')
  local PaddedIndexClass = request('!.concepts.PaddedIndex')

  write_data =
    function(Pam, Write)
      local format = Pam:GetFormat()
      local Image = Pam:GetImage()

      local width = Image:GetWidth()
      local height = Image:GetHeight()

      local LineIndex = PaddedIndexClass.create(height)

      local num_channels
      local num_colors_per_data_line
      if (format == 1) or (format == 2) then
        num_channels = 1
        num_colors_per_data_line = 12
      elseif (format == 3) then
        num_channels = 3
        num_colors_per_data_line = 4
      end

      local max_value
      if (format == 1) then
        max_value = 1
      elseif (format == 2) or (format == 3) then
        max_value = 255
      end

      local Value = PaddedIndexClass.create(max_value)

      for y = 1, height do
        Write:Newline()

        Write:Comment('Line ' .. LineIndex:ToString(y))

        local is_first_item_in_line = true

        for x = 1, width do
          if not is_first_item_in_line then
            Write:Space()
            Write:Space()
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
            Write:Data(Value:ToString(Color[channel]))
          end

          is_first_item_in_line = false

          if (x % num_colors_per_data_line == 0) then
            Write:Newline()
            is_first_item_in_line = true
          end
        end

        if (width % num_colors_per_data_line ~= 0) then
          Write:Newline()
        end
      end
    end
end

local TokensWriter = request('compile.TokensOutputStream')

-- Export:
return
  function(Pam, Output)
    local Write = TokensWriter.create(Output)

    write_header(Pam, Write)
    write_data(Pam, Write)
  end

--[[
  2024 # # # #
  2025 # #
  2026 # # # #
  2026-09-25
]]
