-- Color structure for images

--[[
  Color is a list of color components.

  Color component is float in [0.0, 1.0].
]]

-- Last mod.: 2024-11-25

-- Imports:
local NameList = request('!.concepts.List.AddNames')

local Color = { 0.0, 0.0, 0.0 }

local Names = { 'Red', 'Green', 'Blue' }

NameList(Color, Names)

-- Exports:
return Color

--[[
  2024-11-24
  2024-11-25
]]
