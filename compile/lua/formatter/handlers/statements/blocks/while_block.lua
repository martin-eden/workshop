return
  function(self, node)
    self.printer:emit('while ')
    self:process_node(node.condition)
    self.printer:emit(' do')
    self.printer:emit_nl()
    self.printer:inc_indent()
    self:process_node(node.body)
    self.printer:dec_indent()
    self.printer:emit('end')
  end
