-- Emit header anonymous structure

-- Last mod.: 2024-11-25

-- Exports:
return
  function(self, Image)
    local ImageHeight = #Image.Lines

    local ImageWidth = 0
    if Image.Lines[1] then
      ImageWidth = #Image.Lines[1].Colors
    end

    local WidthIs = string.format(self.DimensionFmt, ImageWidth)

    local HeightIs = string.format(self.DimensionFmt, ImageHeight)

    local MaxValueIs =
      string.format(self.ColorComponentFmt, self.Constants.MaxColorValue)

    return { WidthIs, HeightIs, MaxValueIs }
  end

--[[
  2024-11-03
  2024-11-25
]]
