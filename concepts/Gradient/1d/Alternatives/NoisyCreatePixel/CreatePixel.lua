-- Create pixel with observation noise

-- Last mod.: 2025-04-26

-- Imports:
local MixColors = request('!.concepts.Image.Color.MixColors')

local CreatePixel =
  function(Ours, Theirs, X, Left, Right)
    -- print('CreatePixel', X, Left, Right)

    local LeftColor = Ours:ObservePixel(Theirs, Left, X)
    local RightColor = Ours:ObservePixel(Theirs, Right, X)
    local LeftInfluence = (Right - X) / (Right - Left)

    local Color = MixColors(LeftColor, RightColor, LeftInfluence)

    Theirs:SetPixel(X, Color)
  end

-- Exports:
return CreatePixel

--[[
  2025-04-26
]]
