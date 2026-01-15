-- Create pixel given it's position and two neighbors

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

-- Imports:
local MixColors = request('!.concepts.Image.Color.MixColors')
local GetInfluence = request('!.concepts.Geometry.ThreePoints.GetInfluence')
-- local t2s = request('!.table.as_string')

--[[
  Spawn pixel at given position given additional knowledge about
  two existing pixels.
]]
local CreatePixel =
  function(self, NewCoords, NeibACoords, NeibBCoords)
    local LeftColor = self:GetPixel(NeibACoords)
    local RightColor = self:GetPixel(NeibBCoords)
    local LeftInfluence = GetInfluence(NewCoords, NeibACoords, NeibBCoords)

    -- print('NewCoords', t2s(NewCoords))
    -- print('NeibACoords', t2s(NeibACoords))
    -- print('NeibBCoords', t2s(NeibBCoords))
    -- print('LeftColor', t2s(LeftColor))
    -- print('RightColor', t2s(RightColor))
    -- print('LeftInfluence', LeftInfluence)

    local Color = MixColors(LeftColor, RightColor, LeftInfluence)

    -- print('Color', t2s(Color))

    self:SetPixel(NewCoords, Color)
  end

-- Exports:
return CreatePixel

--[[
  2025-04-23
  2026-01-13
  2026-01-14
]]
