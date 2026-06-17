-- Provide annotated syntax tree for tree (Lua table without cross-links)

--[[
  Author: Martin Eden
  Last mod.: 2026-06-16
]]

-- Imports:
local add_to_list = request('!.concepts.list.add_item')

local RestorableTypes_Map
do
  -- Imports:
  local RestorableTypes = request('!.concepts.lua.RestorableTypeNames')
  local map_values = request('!.table.map_values')

  RestorableTypes_Map = map_values(RestorableTypes)
end

local get_ast =
  function(Data, table_iterator, only_restorable_items, ValueNames)
    local get_ast
    get_ast =
      function(Data)
        local data_type = type(Data)

        if (data_type ~= 'table') then
          return { type = data_type, value = Data }
        end

        if ValueNames[Data] then
          return { type = 'name', value = ValueNames[Data] }
        end

        local Result = { type = 'table' }

        for key, value in table_iterator(Data) do
          if (
              only_restorable_items and
              not (
                RestorableTypes_Map[type(key)] and
                RestorableTypes_Map[type(value)]
              )
            )
          then
            goto next
          end

          local key_slot = get_ast(key)
          local value_slot = get_ast(value)

          add_to_list(Result, { key = key_slot, value = value_slot })

          :: next ::
        end

        return Result
      end

    return get_ast(Data)
  end

-- Export:
return get_ast

--[[
  2018-02
  2020-09
  2022-01
  2024-08
  2026-06-16
]]
