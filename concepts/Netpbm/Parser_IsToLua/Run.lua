-- Gets structure as grouped strings. Returns table with nice names

--[[
  Author: Martin Eden
  Last mod.: 2026-01-15
]]

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
      Format = 'rgb',
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

    Image.Settings.Height = #Image.Data
    Image.Settings.Width = #Image.Data[1]

    do
      local FormatLabel = DataIs[1]
      self.Settings:SetFormatLabel(FormatLabel)
      Image.Settings.Format = self.Settings.ColorFormat
    end

    return Image
  end

--[[
  2024-11 # # #
  2025-03-31
  2026-01-15
]]
