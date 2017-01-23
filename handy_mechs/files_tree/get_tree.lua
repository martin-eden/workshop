return
  function(self)
    local result = self.tree
    local start_node_depth = 0
    while result.parent do
      result = result.parent
      start_node_depth = start_node_depth + 1
    end
    return result, start_node_depth
  end
