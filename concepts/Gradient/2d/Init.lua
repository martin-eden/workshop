-- Setup internal fields, set pixels in image corners

-- Last mod.: 2025-05-06

-- Imports:
local SpawnColor = request('!.concepts.Image.Color.SpawnColor')
local RandomizeColor = request('!.concepts.Image.Color.Randomize')
local LinearGenerator = request('!.concepts.Gradient.1d.Interface')

--[[
  Setup object.

  Uses <ColorFormat>, maybe <StartingColors>.

  Sets <BaseColor>, maybe <LinearGenerator>, <StartingColors>.
  Draws border lines on image rectangle.
]]
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

    self.LinearGenerator = self.LinearGenerator or LinearGenerator

    self.LinearGenerator.ColorFormat = self.ColorFormat
    self.LinearGenerator.LineLength = self.ImageWidth

    local Left = 1
    local Top = 1
    local Right = self.ImageWidth
    local Bottom = self.ImageHeight

    local LeftTop = { X = Left, Y = Top }
    local RightTop = { X = Right, Y = Top }
    local LeftBottom = { X = Left, Y = Bottom }
    local RightBottom = { X = Right, Y = Bottom }

    -- Set corner pixels to starting colors
    do
      self:SetPixel(LeftTop, self.StartingColors.LeftTop)
      self:SetPixel(RightTop, self.StartingColors.RightTop)
      self:SetPixel(LeftBottom, self.StartingColors.LeftBottom)
      self:SetPixel(RightBottom, self.StartingColors.RightBottom)
    end

    -- Draw box on that corner pixels
    do
      self:HStroke(Top, Left, Right)
      self:HStroke(Bottom, Left, Right)

      self:VStroke(Left, Top, Bottom)
      self:VStroke(Right, Top, Bottom)
    end
  end

-- Exports:
return Init

--[[
  2025-04 # # #
  2025-05-06
]]
