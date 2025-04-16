-- 2-d gradient generator without noise

-- Last mod.: 2025-04-15

-- Imports:
local RandomizeColor = request('!.concepts.Image.Color.Randomize')
local SpawnColor = request('!.concepts.Image.Color.SpawnColor')

-- Exports:
return
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

    self:Generate(1, 1, self.ImageWidth, self.ImageHeight)

    self.Image.Width = self.ImageWidth
    self.Image.Height = self.ImageHeight
  end

--[[
  2025-04-04
  2025-04-11
  2025-04-15
]]
