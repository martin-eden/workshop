-- Wrapper for 1-d fractal gradient generator

-- Last mod.: 2025-04-09

-- Imports:
local SpawnColorFromFormat = request('!.concepts.Image.Color.SpawnColor')
local RandomizeColor = request('!.concepts.Image.Color.Randomize')
local GetDistance = request('!.number.integer.get_distance')

--[[
  Fill <.Line> with fractal gradient.

  If <.StartColor> is specified, gradient will start
  from that color. Else it will be set to random color.

  Same for <.EndColor>.
]]
local Run =
  function(self)
    self.BaseColor = SpawnColorFromFormat(self.ColorFormat)
    assert(self.BaseColor, 'Unknown color format.')

    local StartIndex = 1
    local StopIndex = self.ImageLength

    if not self.StartColor then
      self.StartColor = RandomizeColor(new(self.BaseColor))
    end

    if not self.EndColor then
      self.EndColor = RandomizeColor(new(self.BaseColor))
    end

    local LeftPixel = { Index = StartIndex, Color = self.StartColor }

    local RightPixel = { Index = StopIndex, Color = self.EndColor }

    self.Line.Length = self.ImageLength

    self.MaxDistance = GetDistance(LeftPixel.Index, RightPixel.Index)

    self:SetPixel(LeftPixel)
    self:SetPixel(RightPixel)

    self:Plasm(LeftPixel, RightPixel)
  end

-- Exports:
return Run

--[[
  2024-09 # # #
  2024-11 #
  2025-04-04
  2025-04-05
  2025-04-06
]]
