-- Create annotated syntax tree for graph

--[[
  Author: Martin Eden
  Last mod.: 2026-07-11
]]

-- Imports:
local NameGiver = request('!.mechs.name_giver')
local get_assembly_order = request('!.mechs.graph.assembly_order')
local add_to_list = request('!.concepts.list.add_item')

local create_name_rec =
  function(name)
    return { 'name', name }
  end

local create_terminal_type_rec =
  function(data)
    return { type(data), data }
  end

local create_table_rec =
  function()
    return { 'table', { } }
  end

local create_local_def_rec =
  function(name, Value)
    return { 'local_definition', name, Value }
  end

local create_assignment_rec =
  function(dest, index, value)
    return { 'key_assignment', dest, index, value }
  end

local create_return_rec =
  function(Value)
    return { 'return_statement', Value }
  end

local get_num_refs =
  function(NodeRec)
    local Node = NodeRec.Node
    local Refs = NodeRec.refs

    local num_refs = 0

    for Parent, ParentKeys in pairs(Refs) do
      if (Parent == Node) then
        num_refs = num_refs + 1
      end

      for Key in pairs(ParentKeys) do
        if (Key == Node) then
          num_refs = num_refs + 1
        end
        if (Parent[Key] == Node) then
          num_refs = num_refs + 1
        end
      end
    end

    return num_refs
  end

local may_print_inline =
  function(NodeRec)
    if not NodeRec then return true end

    return ((get_num_refs(NodeRec) <= 1) and not NodeRec.part_of_cycle)
  end

local get_ast =
  function(Root, table_iterator)
    local NamedValues = { }

    local get_tree_ast
    get_tree_ast =
      function(Data)
        if NamedValues[Data] then
          return create_name_rec(NamedValues[Data])
        end

        if not is_table(Data) then
          return create_terminal_type_rec(Data)
        end

        local Result = create_table_rec()
        local KeyVals = Result[2]

        for Key, Value in table_iterator(Data) do
          add_to_list(
            KeyVals,
            { get_tree_ast(Key), get_tree_ast(Value) }
          )
        end

        return Result
      end

    local NameGiver = new(NameGiver)

    local NodeRecs, OrderedNodes =
      get_assembly_order(
        Root,
        { also_visit_keys = true, table_iterator = table_iterator }
      )

    local Result = { }
    local ProcessedTables = { }

    for _, Node in ipairs(OrderedNodes) do
      local NodeRec = NodeRecs[Node]

      if (Node == Root) or not may_print_inline(NodeRec) then
        local TableRec

        if NodeRec.part_of_cycle then
          TableRec = create_table_rec()
          local KeyVals = TableRec[2]

          for k, v in table_iterator(Node) do
            local key_is_ok = not is_table(k) or ProcessedTables[k]
            local value_is_ok = not is_table(v) or ProcessedTables[v]

            if not (key_is_ok and value_is_ok) then goto next end

            add_to_list(
              KeyVals,
              { get_tree_ast(k), get_tree_ast(v) }
            )

            :: next ::
          end
        else
          TableRec = get_tree_ast(Node)
        end

        local node_name = NameGiver:give_name(Node)

        NamedValues[Node] = node_name

        add_to_list(
          Result,
          create_local_def_rec(node_name, TableRec)
        )
      end

      ProcessedTables[Node] = true

      if NodeRec.part_of_cycle then
        -- Add links to a table we just processed:
        for Parent, ParentKeys in pairs(NodeRec.refs) do
          if ProcessedTables[Parent] then
            for parent_key in pairs(ParentKeys) do
              local key_slot = get_tree_ast(parent_key)

              add_to_list(
                Result,
                create_assignment_rec(
                  NamedValues[Parent], key_slot, NamedValues[Node]
                )
              )
            end
          end
        end
      end
    end

    add_to_list(
      Result,
      create_return_rec(create_name_rec(NamedValues[Root]))
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
    local PrelastNode = Result[#Result - 1]
    local prelast_type = PrelastNode[1]
    if (prelast_type == 'local_definition') then
      local prelast_value = PrelastNode[3]
      table.remove(Result)
      table.remove(Result)
      add_to_list(Result, create_return_rec(prelast_value))
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
  2026-06 # # #
  2026-07-06
]]
