return
  function(self, node)
    local result =
      {
        index = self:process_node(node[1]),
        start_val = self:process_node(node[2]),
        end_val = self:process_node(node[3]),
      }
    local body_index
    if node[4] and (node[4].type == 'expression') then
      result.increment = self:process_node(node[4])
      body_index = 5
    else
      body_index = 4
    end
    local body = node[body_index]
    if body then
      result.body = self:process_node(body)
    end
    return result
  end
