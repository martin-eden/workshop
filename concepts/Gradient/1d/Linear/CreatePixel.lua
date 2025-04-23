-- Create pixel given it's position and left and right neighbors

-- Last mod.: 2025-04-23

-- Imports:
local MixColors = request('!.concepts.Image.Color.MixColors')

--[[
  This function is intended to be overridden with noise-adding
  flavors.
]]
local CreatePixel =
  function(self, X, Left, Right)
    local LeftColor = self:GetPixel(Left)
    local RightColor = self:GetPixel(Right)
    local LeftInfluence = (Right - X) / (Right - Left)

    local Color = MixColors(LeftColor, RightColor, LeftInfluence)

    self:SetPixel(X, Color)
  end

-- Exports:
return CreatePixel

--[[
  2025-04-23
]]
