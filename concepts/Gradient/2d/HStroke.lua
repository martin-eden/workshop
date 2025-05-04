-- Generate horizontal line in image

-- Last mod.: 2025-04-29

local HStroke =
  function(self, Y, Left, Right)
    -- print('HStroke', Y, Left, Right)

    local LinearGenerator = self.LinearGenerator

    local Width = Right - Left + 1

    LinearGenerator.LineLength = Width

    assert(self:GetPixel({ X = Left, Y = Y }))
    assert(self:GetPixel({ X = Right, Y = Y }))

    LinearGenerator.LeftColor = self:GetPixel({ X = Left, Y = Y })
    LinearGenerator.RightColor = self:GetPixel({ X = Right, Y = Y })

    LinearGenerator:Init()

    for Index = 1, Width do
      LinearGenerator:SetPixel(
        Index,
        self:GetPixel({ X = Left + Index - 1, Y = Y })
      )
    end

    LinearGenerator:Generate()

    for Index = 1, Width do
      self:SetPixel(
        { X = Left + Index - 1, Y = Y },
        LinearGenerator:GetPixel(Index)
      )
    end
  end

-- Exports:
return HStroke

--[[
  2025-04-29
]]
