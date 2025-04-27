-- Return color of pixel in line

-- Last mod.: 2025-04-27

-- Imports:
local Line_GetColor = request('!.concepts.Image.Line.GetColor')

-- Exports:
return
  function(self, Index)
    return Line_GetColor(self.Line, Index)
  end

--[[
  2025-04-16
  2025-04-27
]]
