-- RGB color structure for images

-- Last mod.: 2025-04-05

--[[
  For our processing "color" is just a fixed-length list of
  something. Type of "something" depends what functions you will
  call for that list.

  Okay, for RGB it's list of three floats.
  For grayscale it's list of one float.
  For bitmap it's list of one integer.

  (Text above is not a contract, just trying describe structure
  in simple terms.)
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
  2025-03-28
]]
