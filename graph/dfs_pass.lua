local chunk_name = 'graph.dfs_pass'

require('#base')

-- local default_table_iterator = request('sorted_pairs')
local default_table_iterator = pairs

-- DFS-pass of given graph. Key types does not matter.
local dfs_pass_graph =
  function(graph, graph_external_name, handle_hook, table_iterator)
    assert(is_function(handle_hook))

    local table_iterator_function
    if table_iterator then
      assert(is_function(table_iterator))
      table_iterator_function = table_iterator
    else
      table_iterator_function = default_table_iterator
    end

    local node_status = {}

    local dfs
    dfs =
      function(node, node_external_name, depth)
        handle_hook('entered', node, node_external_name, node_status[node], depth)
        if not node_status[node] then
          if is_table(node) then
            node_status[node] = 'processing'
            for k, v in table_iterator_function(node) do
              dfs(v, k, depth + 1)
            end
            node_status[node] = 'processed'
          end
        end
        handle_hook('left', node, node_external_name, node_status[node], depth)
      end

    dfs(graph, graph_external_name, 0)
  end

tribute(chunk_name, dfs_pass_graph)
