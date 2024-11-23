-- Add names to list entries

-- Last mod.: 2024-11-23

-- Imports:
local InvertTable = request('!.table.invert')

--[[
  Name list entries by attaching metatable to list

  Example:

    local Color = { 128, 0, 255 }
    local ColorNames = { 'Red', 'Green', 'Blue' }
    NameList(Color, ColorNames)
    assert(Color.Red == Color[1])
]]
local NameList =
  function(List, Names)
    local NameKeys = InvertTable(Names)

    local Metatable = {}

    Metatable.__index =
      function(Table, Key)
        return rawget(List, NameKeys[Key])
      end

    setmetatable(List, Metatable)
  end

-- Exports:
return NameList

--[[
  2024-11-23
]]
