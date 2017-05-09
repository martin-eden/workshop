return
  function(self, node)
    local result
    result = self:process_node(node[1]) or {}
    if (node[1].type == 'named_function') then
      result.type = 'local_named_function'
    elseif (node[1].type == 'local_assignment') then
      result.type = 'local_assignment'
    end
    return result
  end
