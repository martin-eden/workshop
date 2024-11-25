-- Image line structure

-- Last mod.: 2024-11-25

-- Imports:
local NameList = request('!.concepts.List.AddNames')

local ImageLine = { {}, 0 }

local Names = { 'Colors', 'Length' }

NameList(ImageLine, Names)

-- Exports:
return ImageLine

--[[
  2024-11-24
  2024-11-25
]]
