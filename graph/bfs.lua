local chunk_name = 'bfs'

local default_table_iterator = pairs

local bfs =
  function(graph, graph_external_name, handle_event, passed_table_iterator)
    assert_table(graph)
    assert_string(graph_external_name)
    assert_function(handle_event)

    local table_iterator = passed_table_iterator or default_table_iterator
    assert_function(table_iterator)

    local queue = request('^.queue').create()
    local storage = {}
    local num_nodes_added = 0

    local add_right =
      function(value, node_name, depth)
        local node =
          {
            value = value,
            depth = depth,
            order_number = num_nodes_added,
            name = node_name,
          }
        queue.increase_tail()
        storage[queue.get_tail()] = node

        num_nodes_added = num_nodes_added + 1

        handle_event('node_added', node.value, node.name, node.depth, node.order_number)
      end

    local extract_left =
      function()
        local result = storage[queue.get_head()]
        storage[queue.get_head()] = nil --< will it really reduce memory consumption?
        queue.increase_head()

        handle_event('node_extracted', result.value, result.name, result.depth, result.order_number)
        return result
      end

    local is_empty =
      function()
        return queue.is_empty()
      end

    local visited = {}
    add_right(graph, graph_external_name, 0)
    while not is_empty() do
      local node = extract_left()
      if is_table(node.value) and not visited[node.value] then
        for subnode_key, subnode in table_iterator(node.value) do
          add_right(subnode, tostring(subnode_key), node.depth + 1)
        end
        visited[node.value] = true
      end
    end
  end

tribute(chunk_name, bfs)
