local get_assembly_order = request('^.^.graph.assembly_order')
local may_print_inline = request('may_print_inline')

--[[
  All above locals may me moved to "self" fields. Moreover,
  _any_ function may be moved to field of "self". I do not know
  now what parameters opening strategy is better: sacral balance
  on inner feelings or just greedy maximum closing/opening.

  As always I prefer to wait real problem before doing changes.
]]

local serialize =
  function(self, root, a_params)
    local assembly_order
    local dfs_params =
      {
        also_visit_keys = true,
        table_iterator = self.serializer.table_iterator,
      }
    self.node_recs, assembly_order = get_assembly_order(root, dfs_params)

    local result_name = 'result'
    local name_giver = self.serializer.name_giver
    for i = 1, (#assembly_order - 1) do
      local node = assembly_order[i]
      local node_rec = self.node_recs[node]
      if not may_print_inline(node_rec) then
        node_rec.name = name_giver:give_name(node)
      end
    end
    self.node_recs[root].name = result_name

    -- collectgarbage()

    for i = 1, (#assembly_order - 1) do --root node is last
      local node_rec = self.node_recs[assembly_order[i]]
      if not may_print_inline(node_rec) then
        self:serialize_subtable(assembly_order[i])
      else
        node_rec.is_defined = true
      end
    end
    self:serialize_subtable(root)

    self.serializer.string_adder:add_term(
      'return ' .. result_name .. self.serializer.token_giver.commands_delimiter
    )
  end

return serialize
