-- Gets structure as grouped strings. Returns table with nice names

-- Last mod.: 2025-03-31

--[[
  Custom Lua format

  Input

    1x2 bitmap

    {
      'P3',
      { '1', '2', '255' },
      {
        { { '0', '128', '255' } },
        { { '128', '255', '0' } },
      }
    }

  is converted to

    {
      { { 0, 128, 255 } },
      { { 128, 255, 0 } },
      Height = 2,
      Width = 1,
      Format = 'Rgb',
    }

  On fail it returns nil.

  Some fail conditions:

    * Holes in data matrix
    * Some color component value is not in range [0, 255]
]]

-- Exports:
return
  function(self, DataIs)
    local ImageIs = DataIs[3]

    local Image = self:ParsePixels(ImageIs)

    if not Image then
      return
    end

    Image.Height = #Image
    Image.Width = #Image[1]

    do
      local FormatLabel = DataIs[1]
      self.Settings:SetFormatLabel(FormatLabel)
      Image.Format = self.Settings.ColorFormat
    end

    return Image
  end

--[[
  2024-11 # # #
  2025-03-31
]]
