-- Set internal values before main job

-- Last mod.: 2025-04-23

-- Imports:
local SpawnColorFromFormat = request('!.concepts.Image.Color.SpawnColor')
local RandomizeColor = request('!.concepts.Image.Color.Randomize')

--[[
  Initialize <.BaseColor>, <.LeftColor>, <.RightColor>, <.Line>.
  Set border pixels.
]]
local InitFunc =
  function(self)
    self.BaseColor = SpawnColorFromFormat(self.ColorFormat)

    self.LeftColor = self.LeftColor or RandomizeColor(new(self.BaseColor))
    self.RightColor = self.RightColor or RandomizeColor(new(self.BaseColor))

    self.Line = {}

    self.Line.Length = self.LineLength

    self:SetPixel(1, self.LeftColor)
    self:SetPixel(self.LineLength, self.RightColor)
  end

-- Exports:
return InitFunc

--[[
  2025-04-16
  2025-04-23
]]
