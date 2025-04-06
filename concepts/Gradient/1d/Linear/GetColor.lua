-- Get pixel's color from our image

-- Last mod.: 2025-04-05

--[[
  Get color value of pixel at given index

  If no color there, returns nil.
]]
local GetPixelColor =
  function(self, Index)
    return self.Line[Index]
  end

-- Exports:
return GetPixelColor

--[[
  2025-04-05
]]
