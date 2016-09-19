return
  function(self, node)
    self.printer:emit('for ')
    self:process_node(node.index)
    self.printer:emit(' = ')
    self:process_node(node.start_val)
    self.printer:emit(', ')
    self:process_node(node.end_val)
    if node.increment then
      self.printer:emit(', ')
      self:process_node(node.increment)
    end
    self.printer:emit(' do')
    self.printer:emit_nl()
    self.printer:inc_indent()
    self:process_node(node.body)
    self.printer:dec_indent()
    self.printer:emit('end')
  end
