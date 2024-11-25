-- Map normalized image colors to byte range

-- Last mod.: 2024-11-25

-- Imports:
local DenormalizeColor = request('^.Color.Denormalize')
local ApplyFunc = request('!.concepts.List.ApplyFunc')

local Denormalize =
  function(Line)
    return ApplyFunc(DenormalizeColor, Line.Colors)
  end

-- Exports:
return Denormalize

--[[
  2024-11-24
]]
