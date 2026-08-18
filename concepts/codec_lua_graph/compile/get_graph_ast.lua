-- Create AST for graph

--[[
  Author: Martin Eden
  Last mod.: 2026-08-20
]]

local get_graph_ast
do
  local get_tree_ast = request('get_tree_ast')

  local create_table_rec
  local create_name_rec
  local create_local_def_rec
  local create_assignment_rec
  local create_return_rec
  do
    local Methods = request('Ast.Methods')
    create_table_rec = Methods.create_table_rec
    create_name_rec = Methods.create_name_rec
    create_local_def_rec = Methods.create_local_def_rec
    create_assignment_rec = Methods.create_assignment_rec
    create_return_rec = Methods.create_return_rec
  end

  local may_print_inline
  do
    local get_num_refs =
      function(NodeRec)
        local Node = NodeRec.node
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

    may_print_inline =
      function(NodeRec)
        if not NodeRec then return true end

        return ((get_num_refs(NodeRec) <= 1) and not NodeRec.part_of_cycle)
      end
  end

  local table_iterator = request('!.table.ordered_pass')
  local get_assembly_order = request('!.mechs.graph.assembly_order')
  local NameGiver = request('!.mechs.name_giver')
  local add_to_list = request('!.concepts.list.add_item')
  local tbl_remove = table.remove

  get_graph_ast =
    function(Root)
      local NamedValues = { }
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
                {
                  get_tree_ast(k, NamedValues),
                  get_tree_ast(v, NamedValues),
                }
              )

              :: next ::
            end
          else
            TableRec = get_tree_ast(Node, NamedValues)
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
          -- Assign links to table we just processed:
          for Parent, ParentKeys in pairs(NodeRec.refs) do
            if ProcessedTables[Parent] then
              for parent_key in pairs(ParentKeys) do
                local key_slot =
                  get_tree_ast(parent_key, NamedValues)

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
        Make "return" return expression, not variable name:

          local t_x = {...}
          return t_x

        converted to

          return {...}
      ]]
      do
        local PrelastNode = Result[#Result - 1]
        local prelast_type = PrelastNode[1]

        if (prelast_type == 'local_definition') then
          local prelast_value = PrelastNode[3]

          tbl_remove(Result)
          tbl_remove(Result)
          add_to_list(Result, create_return_rec(prelast_value))
        end
      end

      return Result
    end
end

-- Export:
return get_graph_ast

--[[
  2018 # # #
  2019 #
  2020 #
  2022 #
  2024 #
  2026 # # # # #
  2026-08-20
]]
