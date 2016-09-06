return
  function(self, node)
    self.printer:emit('for ')
    self:process_node(node.names)
    self.printer:emit(' in ')
    self:process_node(node.expr_list)
    self.printer:emit(' do')
    self.printer:emit_nl()
    self.printer:inc_indent()
    self:process_node(node.body)
    self.printer:dec_indent()
    self.printer:emit('end')
  end
