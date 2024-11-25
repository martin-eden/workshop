-- Map color components to given range

-- Last mod.: 2024-11-25

-- Imports:
local MapToRange = request('!.number.map_to_range')
local ApplyFunc = request('!.concepts.List.ApplyFunc')

local MapTo =
  function(DestRange, Color, SrcRange)
    local CurrentMapToRange =
      function(ColorComponent)
        return MapToRange(DestRange, ColorComponent, SrcRange)
      end

    return ApplyFunc(CurrentMapToRange, Color)
  end

-- Exports:
return MapTo

--[[
  2024-11-24
]]
