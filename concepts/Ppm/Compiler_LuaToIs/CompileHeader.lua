-- Emit header anonymous structure

-- Last mod.: 2024-11-06

-- Exports:
return
  function(self, Ppm)
    local WidthIs =
      string.format(self.DimensionFmt, Ppm.Width)

    local HeightIs =
      string.format(self.DimensionFmt, Ppm.Height)

    local MaxValueIs =
      string.format(self.ColorComponentFmt, self.Constants.MaxColorValue)

    return { WidthIs, HeightIs, MaxValueIs }
  end

--[[
  2024-11-03
]]
