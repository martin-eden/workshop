-- Create function to substitute [Gradient.1d.CreatePixel]

-- Last mod.: 2025-04-23

-- Imports:
local MixColors = request('!.concepts.Image.Color.MixColors')

local CreateExportFunc =
  function(Ours)
    return
      function(Theirs, X, Left, Right)
        local LeftColor = Ours:ObservePixel(Left, X, Theirs)
        local RightColor = Ours:ObservePixel(Right, X, Theirs)
        local LeftInfluence = (Right - X) / (Right - Left)

        local Color = MixColors(LeftColor, RightColor, LeftInfluence)

        Theirs:SetPixel(X, Color)
      end
  end

-- Exports:
return CreateExportFunc

--[[
  2025-04-23
]]
