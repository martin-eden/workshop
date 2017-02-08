-- BFS-pass of given graph

return
  function(self, root)
    assert_table(root)

    self.nodes_status = {}

    local also_visit_keys = self.also_visit_keys
    local nodes_status = self.nodes_status
    local table_iterator = self.table_iterator
    local inform_add = self.inform_add
    local inform_extract = self.inform_extract

    local queue_head = 1
    local queue_tail = 0
    local storage = {}
    local time = 0

    local add_right =
      function(node)
        time = time + 1
        queue_tail = queue_tail + 1
        storage[queue_tail] = node
        inform_add(node, nodes_status[node])
      end

    local extract_left =
      function()
        time = time + 1
        local node = storage[queue_head]
        storage[queue_head] = nil
        queue_head = queue_head + 1
        inform_extract(node, nodes_status[node])
        return node
      end

    local is_empty =
      function()
        return (queue_head > queue_tail)
      end

    local process =
      function(parent, parent_key, node)
        local node_rec = nodes_status[node]
        if not node_rec then
          node_rec =
            {
              discovery_time = time,
              parent = parent,
              parent_key = parent_key,
            }
          if parent then
            node_rec.refs =
              {
                [parent] =
                  {
                    [parent_key] = true,
                  }
              }
          end
          if nodes_status[parent] then
            node_rec.deep = nodes_status[parent].deep + 1
          else
            node_rec.deep = 0
          end

          nodes_status[node] = node_rec
          add_right(node)
        else
          node_rec.refs[parent] = node_rec.refs[parent] or {}
          node_rec.refs[parent][parent_key] = true
        end
      end

    process(nil, nil, root)
    while not is_empty() do
      local node = extract_left()
      if is_table(node) then
        for k, v in table_iterator(node) do
          if is_table(k) then
            process(node, k, v)
          end
          if is_table(v) and also_visit_keys then
            process(node, k, k)
          end
        end
      end
    end
  end
