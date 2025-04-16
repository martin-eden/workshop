-- Set internal values before main job

-- Last mod.: 2025-04-16

-- Imports:
local SpawnColorFromFormat = request('!.concepts.Image.Color.SpawnColor')
local RandomizeColor = request('!.concepts.Image.Color.Randomize')

--[[
  Initialize <.BaseColor>, <.StartColor>, <.EndColor>, <.Line>.
  Set border pixels.
]]
local InitFunc =
  function(self)
    self.BaseColor = SpawnColorFromFormat(self.ColorFormat)

    if not self.StartColor then
      self.StartColor = RandomizeColor(new(self.BaseColor))
    end

    if not self.EndColor then
      self.EndColor = RandomizeColor(new(self.BaseColor))
    end

    self.Line = {}

    self.Line.Length = self.LineLength

    self:SetPixel(1, self.StartColor)
    self:SetPixel(self.LineLength, self.EndColor)
  end

-- Exports:
return InitFunc

--[[
  2025-04-16
]]
