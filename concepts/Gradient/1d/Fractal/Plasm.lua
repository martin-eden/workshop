-- 1-D "plasm" gradient generation core

-- Last mod.: 2025-04-09

--[[
  Generate "1-D plasm": midway linear interpolation between pixels with
  distance-dependent noise.

  Input

    LeftPixel, RightPixel: TPixel
      {
        Index: int
        Color: { 1=Red, 2=Green, 3=Blue: float_ui }
      }

  Output

    Calls <self:SetPixel()>
]]
local MakePlasm =
  function(self, LeftPixel, RightPixel)
    local MidwayPixel = self:CalculateMidwayPixel(LeftPixel, RightPixel)

    if not MidwayPixel then
      return
    end

    self:SetPixel(MidwayPixel)

    self:Plasm(LeftPixel, MidwayPixel)
    self:Plasm(MidwayPixel, RightPixel)
  end

-- Exports:
return MakePlasm

--[[
  2024-10-30
]]
