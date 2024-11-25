-- 2-d image structure

--[[
  2-d image is a list of lines of colors.

  Each color is list of components.

  Each component is float [0.0, 1.0].
]]

-- Last mod.: 2024-11-25

-- Imports:
local NameList = request('!.concepts.List.AddNames')

local Matrix = { {}, 0, }

local Names = { 'Lines', 'NumLines' }

NameList(Matrix, Names)

-- Exports:
return Matrix

--[[
  2024-11-24
  2024-11-25
]]
