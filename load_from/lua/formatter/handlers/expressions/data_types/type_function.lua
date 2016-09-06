return
  function(self, node)
    self.printer:emit('function')
    self:process_node(node.params)
    self.printer:emit_nl()
    self:inc_indent()
    self:process_node(node.body)
    self:dec_indent()
    self.printer:emit('end')
  end
