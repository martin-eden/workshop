-- Plasm generator wrapper

-- Last mod.: 2025-04-04

-- Imports:
local RandomizeColor = request('!.concepts.Image.Color.Randomize')
local GetDistance = request('!.number.integer.get_distance')

--[[
  Draw "linear plasm" to <self.Image>.
]]
local Run =
  function(self)
    self.Image.Length = self.ImageLength

    local StartIndex = 1
    local StopIndex = self.Image.Length

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

    -- If tileable pattern (stripe is ring) then end color is the same
    if self.OnRing then
      RightPixel.Color = new(LeftPixel.Color)
    end

    self.MaxDistance = GetDistance(LeftPixel.Index, RightPixel.Index)

    self:SetPixel(LeftPixel)
    self:SetPixel(RightPixel)

    self:Plasm(LeftPixel, RightPixel)
  end

-- Exports:
return Run

--[[
  2024-09-18
  2024-09-25
  2024-09-30
  2024-11-24
  2025-04-04
]]
