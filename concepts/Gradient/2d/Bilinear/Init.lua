-- Setup internal fields, set pixels in image corners

-- Last mod.: 2025-04-16

-- Imports:
local SpawnColor = request('!.concepts.Image.Color.SpawnColor')
local RandomizeColor = request('!.concepts.Image.Color.Randomize')

local Init =
  function(self)
    self.BaseColor = SpawnColor(self.ColorFormat)

    self.StartingColors.Left.Top =
      self.StartingColors.Left.Top or
      RandomizeColor(new(self.BaseColor))

    self.StartingColors.Right.Top =
      self.StartingColors.Right.Top or
      RandomizeColor(new(self.BaseColor))

    self.StartingColors.Left.Bottom =
      self.StartingColors.Left.Bottom or
      RandomizeColor(new(self.BaseColor))

    self.StartingColors.Right.Bottom =
      self.StartingColors.Right.Bottom or
      RandomizeColor(new(self.BaseColor))

    self.Image.Width = self.ImageWidth
    self.Image.Height = self.ImageHeight

    self:SetPixel(
      self.StartingColors.Left.Top,
      { X = 1, Y = 1 }
    )

    self:SetPixel(
      self.StartingColors.Right.Top,
      { X = self.ImageWidth, Y = 1 }
    )

    self:SetPixel(
      self.StartingColors.Left.Bottom,
      { X = 1, Y = self.ImageHeight }
    )

    self:SetPixel(
      self.StartingColors.Right.Bottom,
      { X = self.ImageWidth, Y = self.ImageHeight }
    )
  end

-- Exports:
return Init

--[[
  2025-04-16
]]
