-- Map normalized color components to byte range

-- Last mod.: 2025-04-26

-- Imports:
local MapTo = request('MapTo')
local ApplyFunc = request('!.concepts.List.ApplyFunc')
local ToInt = math.floor

local Denormalize =
  function(Color)
    local Eps = 1e-10

    local DestRange = { 0, 256 - Eps }
    local SourceRange = { 0.0, 1.0 }

    MapTo(DestRange, Color, SourceRange)

    return ApplyFunc(ToInt, Color)
  end

-- Exports:
return Denormalize

--[[
  2024-11-24
  2025-04-23
  2025-04-26
]]
