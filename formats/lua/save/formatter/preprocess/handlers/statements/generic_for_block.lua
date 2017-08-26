return
  function(self, node)
    return
      {
        names = self:process_node(node[1]),
        expr_list = self:process_node(node[2]),
        body = self:process_node(node[3]),
      }
  end
