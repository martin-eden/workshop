local compile
compile =
  function(node, node_handlers, result)
    if is_string(node) then
      result[#result + 1] = node
    elseif is_table(node) then
      local node_handler = node_handlers[node.type]

      if node.type and not node_handler then
        local msg =
          ('No node handler for type "%s".'):format(node.type)
        io.stderr:write(msg)
      end

      if node_handler then
        result[#result + 1] = node_handler(node)
      else
        for i = 1, #node do
          compile(node[i], node_handlers, result)
        end
      end
    end
  end

return compile
