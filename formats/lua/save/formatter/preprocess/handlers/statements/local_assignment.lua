return
  function(self, node)
    return
      {
        name_list = self:process_node(node[1]),
        val_list = self:process_node(node[2]),
      }
  end
