-- Add names to list entries

--[[
  Author: Martin Eden
  Last mod.: 2026-07-05
]]

--[[
  Name list entries by attaching metatable to list

  Example:

    local Color = { 128, 0, 255 }
    local ColorNames = { 'Red', 'Green', 'Blue' }
    add_names(Color, ColorNames)
    assert(Color.Red == Color[1])
]]

-- Imports:
local invert_table = request('!.table.invert')

local add_names =
  function(List, Names)
    local NamesKeys = invert_table(Names)

    local get_field_by_name =
      function(List, name)
        return rawget(List, NamesKeys[name])
      end

    local method_get =
      function(Table, Key)
        return get_field_by_name(Table, Key)
      end

    local set_field_by_name =
      function(List, name, Value)
        local index = NamesKeys[name]

        if not index then return end

        rawset(List, index, Value)
      end

    local method_set =
      function(Table, Key, Value)
        set_field_by_name(Table, Key, Value)
      end

    local Metatable =
      {
        __index = method_get,
        __newindex = method_set,
      }

    setmetatable(List, Metatable)
  end

-- Exports:
return add_names

--[[
  2024 # #
  2026-07-05
]]
