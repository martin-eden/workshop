-- Set pixel's color in our image

-- Last mod.: 2025-04-23

-- Export:
return
  function(self, Index, Color)
    self.Line[Index] = self.Line[Index] or Color
  end

--[[
  2024-11-24
  2025-04-05
  2025-04-16
  2025-04-23
]]
