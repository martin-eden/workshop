-- Map normalized color components to byte range

-- Last mod.: 2025-04-23

-- Imports:
local MapTo = request('MapTo')
local ToInt = request('!.number.float.to_int')
local ApplyFunc = request('!.concepts.List.ApplyFunc')

local Denormalize =
  function(Color)
    local DestRange = { 0, 255 }
    local SourceRange = { 0.0, 1.0 }

    MapTo(DestRange, Color, SourceRange)

    return ApplyFunc(ToInt, Color)
  end

-- Exports:
return Denormalize

--[[
  2024-11-24
  2025-04-23
]]
