return
  function(self, node)
    if node.expr_list then
      self.printer:emit('return ')
      self:process_node(node.expr_list)
    else
      self.printer:emit('return')
    end
  end
