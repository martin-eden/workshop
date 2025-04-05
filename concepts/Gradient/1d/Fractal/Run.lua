-- Plasm generator wrapper

-- Last mod.: 2025-04-06

-- Imports:
local SpawnColorFromFormat = request('!.concepts.Image.Color.SpawnColor')
local RandomizeColor = request('!.concepts.Image.Color.Randomize')
local GetDistance = request('!.number.integer.get_distance')

--[[
  Draw "linear plasm" to <self.Image>.
]]
local Run =
  function(self)
    self.BaseColor = SpawnColorFromFormat(self.ColorFormat)
    assert(self.BaseColor, 'Unknown color format.')

    self.Line.Length = self.ImageLength

    local StartIndex = 1
    local StopIndex = self.Line.Length

    local LeftPixel =
      {
        Index = StartIndex,
        Color = RandomizeColor(new(self.BaseColor)),
      }

    local RightPixel =
      {
        Index = StopIndex,
        Color = RandomizeColor(new(self.BaseColor)),
      }

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
