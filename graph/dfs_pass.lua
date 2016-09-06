local chunk_name = 'dfs_pass'

-- local default_table_iterator = request('sorted_pairs')
local default_table_iterator = pairs

--[[ DFS-pass of given graph. Key types does not matter. ]]--
local dfs_pass =
  function(graph, graph_external_name, handle_hook, passed_table_iterator)
    assert_table(graph)
    assert_string(graph_external_name)
    assert_function(handle_hook)

    local table_iterator = passed_table_iterator or default_table_iterator
    assert_function(table_iterator)

    local visited = {}

    local dfs
    dfs =
      function(node, node_name, depth)
        handle_hook('entered', node, node_name, visited[node], depth)
        if not visited[node] then
          if is_table(node) then
            visited[node] = 'processing'
            for k, v in table_iterator(node) do
              dfs(v, tostring(k), depth + 1)
            end
            visited[node] = 'processed'
          end
        end
        handle_hook('left', node, node_name, visited[node], depth)
      end

    dfs(graph, graph_external_name, 0)
  end

tribute(chunk_name, dfs_pass)
