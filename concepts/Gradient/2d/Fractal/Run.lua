-- Caller for 2-d "plasm" generator

-- Last mod.: 2025-04-11

-- Imports:
local RandomizeColor = request('!.concepts.Image.Color.Randomize')

-- Exports:
return
  function(self)
    local LU = { X = 1, Y = 1 }
    local LU_Color = RandomizeColor(new(self.BaseColor))

    local RU = { X = self.ImageWidth, Y = 1 }
    local RU_Color = RandomizeColor(new(self.BaseColor))

    local LB = { X = 1, Y = self.ImageHeight }
    local LB_Color = RandomizeColor(new(self.BaseColor))

    local RB = { X = self.ImageWidth, Y = self.ImageHeight }
    local RB_Color = RandomizeColor(new(self.BaseColor))

    -- [[
    LU_Color = { 0.0 }
    RU_Color = { 0.0 }
    LB_Color = { 200 / 255 }
    RB_Color = { 0.0 }
    --]]

    -- <.CalcDistance> uses <.MaxDistance>
    self.MaxDistance = 1.0
    self.MaxDistance = self:CalcDistance(LU, RB)

    self:SetColor(LU_Color, LU)
    self:SetColor(RU_Color, RU)
    self:SetColor(LB_Color, LB)
    self:SetColor(RB_Color, RB)

    self:Plasm(1, 1, self.ImageWidth, self.ImageHeight)

    self.Image.Width = self.ImageWidth
    self.Image.Height = self.ImageHeight
  end

--[[
  2025-04-04
  2025-04-11
]]
