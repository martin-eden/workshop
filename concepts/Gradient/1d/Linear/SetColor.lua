-- Set pixel's color in our image

-- Last mod.: 2025-04-05

--[[
  Set line pixel at given index to given color

  Color is expected to be list of floats.
]]
local SetPixelColor =
  function(self, Index, Color)
    self.Line[Index] = Color
  end

-- Exports:
return SetPixelColor

--[[
  2025-04-05
]]
