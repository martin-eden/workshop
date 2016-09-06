local process_node = request('process_node')

local process_list =
  function(self, node)
    local result = {}
    for i = 1, #node do
      result[i] = self:process_node(node[i])
    end
    result.type = node.name
    return result
  end

return process_list
