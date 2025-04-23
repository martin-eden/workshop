-- Setup internal fields, set pixels in image corners

-- Last mod.: 2025-04-22

-- Imports:
local SpawnColor = request('!.concepts.Image.Color.SpawnColor')
local RandomizeColor = request('!.concepts.Image.Color.Randomize')

local Init =
  function(self)
    self.BaseColor = SpawnColor(self.ColorFormat)

    self.StartingColors.LeftTop =
      self.StartingColors.LeftTop or
      RandomizeColor(new(self.BaseColor))

    self.StartingColors.RightTop =
      self.StartingColors.RightTop or
      RandomizeColor(new(self.BaseColor))

    self.StartingColors.LeftBottom =
      self.StartingColors.LeftBottom or
      RandomizeColor(new(self.BaseColor))

    self.StartingColors.RightBottom =
      self.StartingColors.RightBottom or
      RandomizeColor(new(self.BaseColor))

    self.Image.Width = self.ImageWidth
    self.Image.Height = self.ImageHeight

    local LeftTop = { X = 1, Y = 1 }
    local RightTop = { X = self.ImageWidth, Y = 1 }
    local LeftBottom = { X = 1, Y = self.ImageHeight }
    local RightBottom = { X = self.ImageWidth, Y = self.ImageHeight }

    -- Set corner pixels to starting colors
    do
      self:SetPixel(self.StartingColors.LeftTop, LeftTop)
      self:SetPixel(self.StartingColors.RightTop, RightTop)
      self:SetPixel(self.StartingColors.LeftBottom, LeftBottom)
      self:SetPixel(self.StartingColors.RightBottom, RightBottom)
    end
  end

-- Exports:
return Init

--[[
  2025-04-16
  2025-04-22
]]
