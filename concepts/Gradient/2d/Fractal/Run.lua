-- Caller for 2-d "plasm" generator

-- Last mod.: 2025-04-11

-- Imports:
local RandomizeColor = request('!.concepts.Image.Color.Randomize')
local IntMid = request('!.number.integer.get_middle')

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

    --[[
    LU_Color = { 0.0 }
    RU_Color = { 200 / 255 }
    LB_Color = { 200 / 255 }
    RB_Color = { 0.0 }
    --]]

    -- Calculate <.MaxDistance>
    do
      --[[
        First, <.CalcDistance> uses <.MaxDistance>.

        Second, although theoretical maximum distance is
        between points in opposite corners, practical maximum distance
        is between corner and midpoint.

          IntMid() returns nearest middle so longest practical distance
          is between middle and bottom right.
      ]]
      self.MaxDistance = 1.0
      local Mid = { X = IntMid(LU.X, RB.X), Y = IntMid(LU.Y, RB.Y) }
      self.MaxDistance = self:CalcDistance(Mid, RB)
    end

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
