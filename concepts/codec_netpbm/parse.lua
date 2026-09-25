-- Parse image from PBM, PGM or PPM format

--[[
  Author: Martin Eden
  Last mod.: 2026-09-26
]]

local load_header
local load_data
do
  local get_next_item = request('parse.get_next_item')

  do
    local ExtToInt_Map
    do
      local Syntels = request('^.Syntels')

      ExtToInt_Map =
        {
          [Syntels.monochrome_label] = 1,
          [Syntels.grayscale_label] = 2,
          [Syntels.color_label] = 3,
        }
    end

    local is_natural = request('!.number.is_natural')

    load_header =
      function(Input)
        local format = ExtToInt_Map[get_next_item(Input)]
        assert(format, 'Unknown format label.')

        local width = tonumber(get_next_item(Input))
        assert(is_natural(width))

        local height = tonumber(get_next_item(Input))
        assert(is_natural(height))

        --[[
          P2 and P3 formats has "max channel value" value in header

          We're not using it but should consume.
        ]]
        if (format == 2) or (format == 3) then
          get_next_item(Input)
        end

        return format, width, height
      end
  end
  do
    local read_color
    do
      local normalize_color = request('!.concepts.Image.Color.Normalize')
      read_color =
        function(Input, num_channels)
          local Color = { }
          for channel = 1, num_channels do
            local value = tonumber(get_next_item(Input))
            assert_integer(value)
            assert(value >= 0)
            Color[channel] = value
          end
          normalize_color(Color)

          return Color
        end
    end

    load_data =
      function(Pam, Input)
        local format = Pam:GetFormat()
        local Image = Pam:GetImage()

        local width = Image:GetWidth()
        local height = Image:GetHeight()

        local num_channels
        if (format == 1) or (format == 2) then
          num_channels = 1
        elseif (format == 3) then
          num_channels = 3
        end

        for y = 1, height do
          for x = 1, width do
            Me:SetColor(read_color(Input, num_channels), x, y)
          end
        end
      end
  end
end

local PamClass = request('Pam')

-- Export:
return
  function(Input)
    local Pam = PamClass.create(load_header(Input))
    load_data(Pam, Input)

    return Pam
  end

--[[
  2024 #
  2026 # #
  2026-09-25
]]
