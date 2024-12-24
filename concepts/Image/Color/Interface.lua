-- Color structure for images

-- Last mod.: 2024-12-24

--[[
  Color is a list of color components.

  Color component is float in [0.0, 1.0].
]]

-- Imports:
local NameList = request('!.concepts.List.AddNames')

local Color = { 0.0, 0.0, 0.0 }

local Names = { 'Red', 'Green', 'Blue' }

-- Annotate component indices (sets metatable)
NameList(Color, Names)

-- Exports:
return Color

--[[
  2024-11-24
  2024-11-25
]]
