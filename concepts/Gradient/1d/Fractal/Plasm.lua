-- 1-D "plasm" gradient generation core

-- Last mod.: 2025-04-16

-- Imports:
local IntDist = request('!.number.integer.get_distance')

-- Exports:
--[[
  Generate "1-D plasm": midway linear interpolation
  with distance-dependent noise.
]]
return
  function(self, FirstIndex, LastIndex)
    if (IntDist(FirstIndex, LastIndex) <= 1) then
      return
    end

    local MidIndex, MidColor =
      self:CalculateMidwayPixel(FirstIndex, LastIndex)

    self:SetPixel(MidIndex, MidColor)

    self:Plasm(FirstIndex, MidIndex)
    self:Plasm(MidIndex, LastIndex)
  end

--[[
  2024-10-30
  2025-04-16
]]
