local get_num_refs =
  function(node_rec)
    local result = 0
    if node_rec.refs then
      local node = node_rec.node
      for parent, parent_keys in pairs(node_rec.refs) do
        if (parent == node) then
          result = result + 1
        end
        for key in pairs(parent_keys) do
          if (parent[key] == node) then
            result = result + 1
          end
          if (key == node) then
            result = result + 1
          end
        end
      end
    end
    return result
  end

local may_print_inline =
  function(node_rec)
    return
      not node_rec or
      (
        (get_num_refs(node_rec) <= 1) and
        not node_rec.part_of_cycle
      )
  end

local get_assembly_order = request('!.mechs.graph.assembly_order')

return
  function(self, data)
    local table_serializer = self.table_serializer
    local table_iterator = table_serializer.table_iterator

    local node_recs, nodes_ordered =
      get_assembly_order(
        data,
        {also_visit_keys = true, table_iterator = table_iterator}
      )

    local result = {}
    local processed_tables = {}

    for i = 1, #nodes_ordered do
      local subtable = nodes_ordered[i]
      local node_rec = node_recs[subtable]
      if
        not may_print_inline(node_rec) or
        (subtable == data)
      then
        if node_rec.part_of_cycle then
          local ignored_values = {}
          for parent in pairs(node_rec.refs) do
            if not processed_tables[parent] then
              ignored_values[parent] = true
            end
          end
          table_serializer.ignored_values = ignored_values
        end
        local value_slot = table_serializer:get_ast(subtable)
        local name_slot = table_serializer.value_names[subtable]
        result[#result + 1] =
          {
            type = 'local_assignment',
            name = name_slot,
            value = value_slot,
          }
        --[[
        print(
          'not may_print_inline',
          subtable,
          get_num_refs(node_rec),
          table_serializer.value_names[subtable],
          subtable == data,
          node_rec.part_of_cycle
        )
        --]]
      end
      processed_tables[subtable] = true

      if node_rec.part_of_cycle then
        -- Add links to a table we just processed:
        for parent, parent_keys in pairs(node_rec.refs) do
          if processed_tables[parent] then
            for parent_key in pairs(parent_keys) do
              local key_name =
                table_serializer.value_names[parent_key] or
                tostring(parent_key)
              local name_slot =
                {
                  type = 'name',
                  value =
                    {
                      table_serializer.value_names[parent],
                      '[', key_name, ']',
                    }
                }
              local value_slot = table_serializer.value_names[subtable]
              result[#result + 1] =
                {
                  type = 'assignment',
                  name = name_slot,
                  value = value_slot,
                }
            end
          end
        end
      end
    end

    result[#result + 1] =
      {
        type = 'return_statement',
        value = table_serializer.value_names[data],
      }

    return result
  end
