-- Create pixel with observation noise

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

-- Imports:
local MixColors = request('!.concepts.Image.Color.MixColors')
local GetInfluence = request('!.concepts.Geometry.ThreePoints.GetInfluence')

local CreatePixel =
  function(Ours, Theirs, NewPoint, PointA, PointB)
    local PointAColor = Ours:ObservePixel(Theirs, NewPoint, PointA)
    local PointBColor = Ours:ObservePixel(Theirs, NewPoint, PointB)
    local PointAInfluence = GetInfluence(NewPoint, PointA, PointB)

    local NewColor = MixColors(PointAColor, PointBColor, PointAInfluence)

    Theirs:SetPixel(NewPoint, NewColor)
  end

-- Exports:
return CreatePixel

--[[
  2025-04-26
  2026-01-13
  2026-01-14
]]
