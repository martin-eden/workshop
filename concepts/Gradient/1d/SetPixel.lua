-- Set pixel's color in our image

-- Last mod.: 2025-04-27

-- Imports:
local Line_SetColor = request('!.concepts.Image.Line.SetColor')

-- Exports:
return
  function(self, Index, Color)
    Line_SetColor(self.Line, Index, Color)
  end

--[[
  2024-11-24
  2025-04-05
  2025-04-16
  2025-04-23
  2025-04-27
]]
