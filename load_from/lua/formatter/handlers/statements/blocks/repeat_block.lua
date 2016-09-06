return
  function(self, node)
    self.printer:emit('repeat')
    self.printer:emit_nl()
    self.printer:inc_indent()
    self:process_node(node.body)
    self.printer:dec_indent()
    self.printer:emit('until ')
    self:process_node(node.condition)
  end
