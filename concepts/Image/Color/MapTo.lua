-- Map color components to given range

-- Last mod.: 2025-04-27

-- Imports:
local MapToRange = request('!.number.map_to_range')
local ApplyFunc = request('!.concepts.List.ApplyFunc')

local Generate_Component_MapToRange =
  function(DestRange, SrcRange)
    return
      function(ColorComponent)
        return MapToRange(DestRange, ColorComponent, SrcRange)
      end
  end

local MapTo =
  function(DestRange, Color, SrcRange)
    local Component_MapToRange =
      Generate_Component_MapToRange(DestRange, SrcRange)

    return ApplyFunc(Component_MapToRange, Color)
  end

-- Exports:
return MapTo

--[[
  2024-11-24
  2025-04-27
]]
