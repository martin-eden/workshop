local chunk_name = 'assembly_order'

local dfs = request('dfs')
assert_function(dfs)

local assembly_order =
  function(graph, options)
    options = options or {}

    local assembly_order_seq = {}

    options.handler =
      function(event_name, node, node_rec, deep)
        if (event_name == 'processed') then
          assembly_order_seq[#assembly_order_seq + 1] = node
        end
      end

    local node_recs = dfs(graph, options)

    return node_recs, assembly_order_seq
  end

tribute(chunk_name, assembly_order)
