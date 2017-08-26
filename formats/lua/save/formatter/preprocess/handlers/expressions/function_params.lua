return
  function(self, node)
    local result = {}

    if node[1] and (node[1].type ~= 'vararg') then
      local name_part = node[1]
      result = self:process_list(name_part)
    end

    if node[#node] and (node[#node].type == 'vararg') then
      local vararg = node[#node]
      result[#result + 1] = self:process_node(vararg)
    end

    result.type = node.type

    return result
  end
