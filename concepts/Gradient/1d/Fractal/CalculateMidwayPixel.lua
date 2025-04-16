-- Calculate midway pixel with noise

-- Last mod.: 2025-04-16

-- Imports:
local GetIntDistance = request('!.number.integer.get_distance')
local GetIntMiddle = request('!.number.integer.get_middle')
local MixNumbers = request('!.number.mix_numbers')
local ClampUi = request('!.number.constrain_ui')

--[[
  Calculate midway pixel with distance-dependent noise

  Returns index and color.

  On fail explodes.
]]
local CalculateMidwayPixel =
  function(self, FirstIndex, LastIndex)
    local IntDistance = GetIntDistance(FirstIndex, LastIndex)

    assert(IntDistance > 1)

    local MidIndex = GetIntMiddle(FirstIndex, LastIndex)

    local FirstColor = self:GetPixel(FirstIndex)
    local LastColor = self:GetPixel(LastIndex)
    local FirstInfluence = GetIntDistance(MidIndex, LastIndex) / IntDistance

    local FloatDistance = IntDistance / self.MaxDistance

    local MidColor = new(self.BaseColor)

    for ComponentIndex = 1, #MidColor do
      local MidValue =
        MixNumbers(
          FirstColor[ComponentIndex],
          LastColor[ComponentIndex],
          FirstInfluence
        )

      MidValue = MidValue + self:MakeDistanceNoise(FloatDistance)

      MidValue = ClampUi(MidValue)

      MidColor[ComponentIndex] = MidValue
    end

    return MidIndex, MidColor
  end

-- Exports:
return CalculateMidwayPixel

--[[
  2024-09 #
  2024-11 # # # #
  2025-04-09
  2025-04-16
]]
