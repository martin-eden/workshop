-- Normalize image color components that are in byte range [0, 255]

-- Last mod.: 2024-11-25

-- Imports:
local MapTo = request('MapTo')

local Normalize =
  function(Color)
    local DestRange = { 0.0, 1.0 }
    local SourceRange = { 0, 255 }

    return MapTo(DestRange, Color, SourceRange)
  end

-- Exports:
return Normalize

--[[
  2024-11-24
]]
