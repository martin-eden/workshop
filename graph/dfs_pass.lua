local chunk_name = 'dfs_pass'

local default_table_iterator = request('^.table.ordered_pass')
-- local default_table_iterator = pairs

--[[ DFS-pass of given graph. Key types does not matter. ]]--
local dfs_pass =
  function(graph, graph_external_name, handle_hook, external_table_iterator)
    assert_table(graph)
    assert_function(handle_hook)

    local table_iterator = external_table_iterator or default_table_iterator
    assert_function(table_iterator)

    local visited = {}
    local handler_data = {}

    local dfs
    dfs =
      function(node, node_key, depth)
        local node_entry_status = visited[node]
        handle_hook('entered', node, node_key, node_entry_status, depth, handler_data)
        if not visited[node] then
          if is_table(node) then
            visited[node] = 'processing'
            for k, v in table_iterator(node) do
              dfs(v, k, depth + 1)
            end
            visited[node] = 'processed'
          end
        end
        handle_hook('left', node, node_key, node_entry_status, depth, handler_data)
      end

    handle_hook('start', graph, graph_external_name, nil, 0, handler_data)
    dfs(graph, graph_external_name, 0)
    return handle_hook('finish', graph, graph_external_name, nil, 0, handler_data)
  end

tribute(chunk_name, dfs_pass)
