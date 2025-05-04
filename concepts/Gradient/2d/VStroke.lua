-- Generate vertical line in image

-- Last mod.: 2025-04-29

-- Symmetrical to .HStroke()
local VStroke =
  function(self, X, Top, Bottom)
    -- print('VStroke', X, Top, Bottom)

    local LinearGenerator = self.LinearGenerator

    local Height = Bottom - Top + 1

    LinearGenerator.LineLength = Height

    assert(self:GetPixel({ X = X, Y = Top }))
    assert(self:GetPixel({ X = X, Y = Bottom}))

    LinearGenerator.LeftColor = self:GetPixel({ X = X, Y = Top })
    LinearGenerator.RightColor = self:GetPixel({ X = X, Y = Bottom})

    LinearGenerator:Init()

    for Index = 1, Height do
      LinearGenerator:SetPixel(
        Index,
        self:GetPixel({ X = X, Y = Top + Index - 1 })
      )
    end

    LinearGenerator:Generate()

    for Index = 1, Height do
      self:SetPixel(
        { X = X, Y = Top + Index - 1 },
        LinearGenerator:GetPixel(Index)
      )
    end
  end

-- Exports:
return VStroke

--[[
  2025-04-29
]]
