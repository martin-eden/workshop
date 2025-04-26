-- Quantize color before setting pixel

-- Last mod.: 2025-04-26

-- Imports:
local Granulate = request('!.number.float.granulate')

local GranulateColor =
  function(self, Color)
    for Index = 1, #Color do
      Color[Index] = Granulate(Color[Index], self.NumGradations)
    end
  end

-- Exports:
return GranulateColor

--[[
  2025-04-26
]]
