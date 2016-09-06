local dfs = request('dfs')

local assembly_order =
  function(graph, options)
    options = options or {}

    local assembly_order_seq = {}

    options.handle_leave =
      function(node, node_rec, deep)
        assembly_order_seq[#assembly_order_seq + 1] = node
      end

    local node_recs = dfs(graph, options)

    return node_recs, assembly_order_seq
  end

return assembly_order
