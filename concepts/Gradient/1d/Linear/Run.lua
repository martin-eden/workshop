-- Linear 1-d generator

-- Last mod.: 2025-04-16

-- Imports:
local GetIntDistance = request('!.number.integer.get_distance')
local MixNumbers = request('!.number.mix_numbers')

--[[
  Generate linear gradient between two points

  If no endline pixels are set, we'll set them to random colors.
]]
local Run =
  function(self)
    self:Init()

    local StartColor = self.StartColor
    local EndColor = self.EndColor

    if (self.LineLength <= 2) then
      return
    end

    local FirstIndex = 1
    local LastIndex = self.LineLength

    local MaxDist = GetIntDistance(FirstIndex, LastIndex)

    for PixelIndex = FirstIndex + 1, LastIndex - 1 do
      local StartInfluence = GetIntDistance(PixelIndex, LastIndex) / MaxDist

      local Color = new(self.BaseColor)

      for ColorComponentIndex in ipairs(Color) do
        local ColorComponentValue =
          MixNumbers(
            StartColor[ColorComponentIndex],
            EndColor[ColorComponentIndex],
            StartInfluence
          )

        Color[ColorComponentIndex] = ColorComponentValue
      end

      self:SetPixel(PixelIndex, Color)
    end
  end

-- Exports:
return Run

--[[
  2025-04-05
  2025-04-15
]]
