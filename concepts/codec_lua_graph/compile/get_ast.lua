-- Create annotated syntax tree for graph

--[[
  Author: Martin Eden
  Last mod.: 2026-06-19
]]

-- Imports:
local NameGiver = request('!.mechs.name_giver')
local get_assembly_order = request('!.mechs.graph.assembly_order')
local add_to_list = request('!.concepts.list.add_item')

local get_num_refs =
  function(NodeRec)
    local num_refs = 0

    if NodeRec.refs then
      local Node = NodeRec.Node

      for parent, parent_keys in pairs(NodeRec.refs) do
        if (parent == Node) then
          num_refs = num_refs + 1
        end

        for key in pairs(parent_keys) do
          if (parent[key] == Node) then
            num_refs = num_refs + 1
          end
          if (key == Node) then
            num_refs = num_refs + 1
          end
        end
      end
    end

    return num_refs
  end

local may_print_inline =
  function(NodeRec)
    return
      not NodeRec or
      (
        (get_num_refs(NodeRec) <= 1) and
        not NodeRec.part_of_cycle
      )
  end

local tree_get_ast =
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

local get_ast =
  function(Data, table_iterator)
    local NameGiver = new(NameGiver)

    local NodeRecs, OrderedNodes =
      get_assembly_order(
        Data,
        { also_visit_keys = true, table_iterator = table_iterator }
      )

    local Result = { }
    local ProcessedTables = { }
    local ValueNames = { }

    for _, Node in ipairs(OrderedNodes) do
      local NodeRec = NodeRecs[Node]

      if
        not may_print_inline(NodeRec) or
        (Node == Data)
      then
        local TableRec

        if NodeRec.part_of_cycle then
          TableRec = { type = 'table' }

          for k, v in table_iterator(Node) do
            local key_is_ok = not is_table(k) or ProcessedTables[k]
            local value_is_ok = not is_table(v) or ProcessedTables[v]

            if key_is_ok and value_is_ok then
              add_to_list(
                TableRec,
                {
                  Key = tree_get_ast(k, table_iterator, ValueNames),
                  Value = tree_get_ast(v, table_iterator, ValueNames),
                }
              )
            end
          end
        else
          TableRec = tree_get_ast(Node, table_iterator, ValueNames)
        end

        local node_name = NameGiver:give_name(Node)

        ValueNames[Node] = node_name

        add_to_list(
          Result,
          {
            type = 'local_definition',
            name = node_name,
            Value = TableRec,
          }
        )
      end

      ProcessedTables[Node] = true

      if NodeRec.part_of_cycle then
        -- Add links to a table we just processed:
        for parent, parent_keys in pairs(NodeRec.refs) do
          if ProcessedTables[parent] then
            for parent_key in pairs(parent_keys) do
              local key_slot
              local key_name = ValueNames[parent_key]

              if key_name then
                key_slot = { type = 'name', value = key_name }
              else
                key_slot = { type = type(parent_key), value = parent_key }
              end

              add_to_list(
                Result,
                {
                  type = 'assignment',
                  dest_name = ValueNames[parent],
                  IndexValue = key_slot,
                  src_name = ValueNames[Node],
                }
              )
            end
          end
        end
      end
    end

    add_to_list(
      Result,
      {
        type = 'return_statement',
        Value = { type = 'name', value = ValueNames[Data] }
      }
    )

    --[[
      Apply shortcut:

        ...
        local t_x = {...}
        return t_x

      can be shortened to

        ...
        return {...}
    ]]
    assert(#Result >= 2)

    if (Result[#Result - 1].type == 'local_definition') then
      table.remove(Result)
      local LastValue = Result[#Result].Value
      Result[#Result] =
        {
          type = 'return_statement',
          Value = LastValue,
        }
    end

    return Result
  end

-- Export:
return get_ast

--[[
  2018 # # #
  2019 #
  2020 #
  2022 #
  2024 #
  2026-06-17
  2026-06-19
  2026-06-20
]]
