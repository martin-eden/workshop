-- Setup internal fields, set pixels in image corners

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

-- Imports:
local SpawnColor = request('!.concepts.Image.Color.SpawnColor')
local RandomizeColor = request('!.concepts.Image.Color.Randomize')

--[[
  Setup object.

  Uses <ColorFormat>, maybe <StartingColors>.

  Sets <BaseColor>, maybe <StartingColors>.
  Draws corner pixels on image rectangle.
]]
local Init =
  function(self)
    -- Set corner pixels to starting colors
    do
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

      local Left = 1
      local Top = 1
      local Right = self.ImageWidth
      local Bottom = self.ImageHeight

      local Image = self.Image
      Image:SetPixel({ Top, Left }, self.StartingColors.LeftTop)
      Image:SetPixel({ Top, Right }, self.StartingColors.RightTop)
      Image:SetPixel({ Bottom, Left }, self.StartingColors.LeftBottom)
      Image:SetPixel({ Bottom, Right }, self.StartingColors.RightBottom)
    end

    -- Initialize Image's Width and Height fields
    do
      self.Image.Settings.Width = self.ImageWidth
      self.Image.Settings.Height = self.ImageHeight
      self.Image.Settings.ColorFormat = self.ColorFormat
    end
  end

-- Exports:
return Init

--[[
  2025 # # # #
  2026-01-13
  2026-01-14
]]
