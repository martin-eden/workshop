-- Create color entity

-- Last mod.: 2024-11-25

-- Imports:
local ImageColor = request('^.Interface')
local NameList = request('!.concepts.List.AddNames')
local Patch = request('!.table.patch')

local ComponentNames = { 'Red', 'Green', 'Blue' }

--[[
  Spawn color entity

  Adds labels to list via metatable:

    [1] == .Red, [2] == .Green, [3] == .Blue
]]
local Create =
  function(Values)
    local Color = new(ImageColor)
    NameList(Color, ComponentNames)

    if is_table(Values) then
      Patch(Color, Values)
    end

    return Color
  end

-- Exports:
return Create

--[[
  2024-11-24
]]
