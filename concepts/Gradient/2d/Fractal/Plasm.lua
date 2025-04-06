-- 2-d gradient noise recursive filler

-- Last mod.: 2025-04-04

-- Imports:
local IntDistance = request('!.number.integer.get_distance')

--[[
  Receives corners of image rectangle. Makes 4 subrectangles from
  them. Calls itself.

  +--------------------------------------------+
  | LU                  CU                  RU |
  |  *                   *                   * |
  |                                            |
  |                                            |
  | LC                  CC                  RC |
  |  *                   *                   * |
  |                                            |
  |                                            |
  | LB                  CB                  RB |
  |  *                   *                   * |
  +--------------------------------------------+
]]

local Plasm =
  function(self, LU, RU, LB, RB)
    local dx = IntDistance(LU.X, RU.X)
    local dy = IntDistance(LU.Y, LB.Y)

    -- print(LU.X, LU.Y, RB.X, RB.Y)
    -- print(dx, dy)

    if ((dx <= 1) and (dy <= 1)) then
      return
    end

    local CC = self:CalculateMidwayPixel(LU, RU, LB, RB)

    self:SetPixel(CC)

    local CU = self:CalculateSidePixel(LU, RU, CC)
    if CU then
      self:SetPixel(CU)
    end

    local LC = self:CalculateSidePixel(LU, LB, CC)
    if LC then
      self:SetPixel(LC)
    end

    local RC = self:CalculateSidePixel(RU, RB, CC)
    if RC then
      self:SetPixel(RC)
    end

    local CB = self:CalculateSidePixel(LB, RB, CC)

    if CB then
      self:SetPixel(CB)
    end

    if CU and LC then
      self:Plasm(LU, CU, LC, CC)
    end

    if CU and RC then
      self:Plasm(CU, RU, CC, RC)
    end

    if LC and CB then
      self:Plasm(LC, CC, LB, CB)
    end

    if RC and CB then
      self:Plasm(CC, RC, CB, RB)
    end
  end

-- Exports:
return Plasm

--[[
  2025-04-04
]]
