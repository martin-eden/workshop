-- Provide annotated syntax tree for table

--[[
  Author: Martin Eden
  Last mod.: 2026-06-18
]]

--[[
  It is used for both trees and graphs

  For graph, caller should setup <NamedNodes_Map> with entries we
  should not visit.
]]

-- Imports:
local add_to_list = request('!.concepts.list.add_item')

local create_ast =
  function(Data, table_iterator, NamedNodes_Map)
    local create_ast
    create_ast =
      function(Data)
        local data_type = type(Data)

        if NamedNodes_Map[Data] then
          return { type = 'name', value = NamedNodes_Map[Data] }
        end

        if (data_type ~= 'table') then
          return { type = data_type, value = Data }
        end

        local Result = { type = 'table' }

        for Key, Value in table_iterator(Data) do
          add_to_list(
            Result,
            {
              Key = create_ast(Key),
              Value = create_ast(Value),
            }
          )
        end

        return Result
      end

    return create_ast(Data)
  end

-- Export:
return create_ast

--[[
  2018-02
  2020-09
  2022-01
  2024-08
  2026-06-16
  2026-06-18
]]
