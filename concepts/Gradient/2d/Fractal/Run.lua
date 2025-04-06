-- Caller for 2-d "plasm" generator

-- Last mod.: 2025-04-04

-- Imports:
local RandomizeColor = request('!.concepts.Image.Color.Randomize')

-- Exports:
return
  function(self)
    local LU =
      {
        X = 1,
        Y = 1,
        Color = RandomizeColor(new(self.BaseColor)),
      }
    local RU =
      {
        X = self.ImageWidth,
        Y = 1,
        Color = RandomizeColor(new(self.BaseColor)),
      }
    local LB =
      {
        X = 1,
        Y = self.ImageHeight,
        Color = RandomizeColor(new(self.BaseColor)),
      }
    local RB =
      {
        X = self.ImageWidth,
        Y = self.ImageHeight,
        Color = RandomizeColor(new(self.BaseColor)),
      }

    -- [[
    LU.Color = { 1.0 }
    RU.Color = { 1.0 }
    LB.Color = { 0.0 }
    RB.Color = { 0.0 }
    --]]

    self:SetPixel(LU)
    self:SetPixel(RU)
    self:SetPixel(LB)
    self:SetPixel(RB)

    self:Plasm(LU, RU, LB, RB)
  end

--[[
  2025-04-04
]]
