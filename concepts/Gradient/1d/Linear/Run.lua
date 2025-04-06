-- Linear 1-d generator

-- Last mod.: 2025-04-05

-- Imports:
local SpawnColorFromFormat = request('!.concepts.Image.Color.SpawnColor')
local RandomizeColor = request('!.concepts.Image.Color.Randomize')
local GetIntDistance = request('!.number.integer.get_distance')
local MixNumbers = request('!.number.mix_numbers')

--[[
  Generate linear gradient between two points

  If no endline pixels are set, we'll set them to random colors.
]]
local Run =
  function(self)
    self.BaseColor = SpawnColorFromFormat(self.ColorFormat)
    assert(self.BaseColor, 'Unknown color format.')

    if not self.StartColor then
      self.StartColor = RandomizeColor(new(self.BaseColor))
    end

    local LeftColor = self.StartColor

    if not self.EndColor then
      self.EndColor = RandomizeColor(new(self.BaseColor))
    end

    local RightColor = self.EndColor

    local FirstIndex = 1
    local LastIndex = self.LineLength

    self:SetColor(FirstIndex, LeftColor)
    self:SetColor(LastIndex, RightColor)

    if (self.LineLength <= 2) then
      return
    end

    local TotalDist = GetIntDistance(FirstIndex, LastIndex)

    for PixelIndex = FirstIndex + 1, LastIndex - 1 do
      local NormDistToRight = GetIntDistance(PixelIndex, LastIndex) / TotalDist

      local LeftSideInfluence = NormDistToRight

      local Color = new(self.BaseColor)

      for ColorComponentIndex in ipairs(Color) do
        local ColorComponentValue =
          MixNumbers(
            LeftColor[ColorComponentIndex],
            RightColor[ColorComponentIndex],
            LeftSideInfluence
          )

        Color[ColorComponentIndex] = ColorComponentValue
      end

      self:SetColor(PixelIndex, Color)
    end

    self.Line.Length = self.LineLength
  end

-- Exports:
return Run

--[[
  2025-04-05
]]
