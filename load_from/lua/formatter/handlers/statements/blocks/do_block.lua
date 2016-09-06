return
  function(self, node)
    self.printer:emit('do')
    self.printer:inc_indent()
    self.printer:emit_nl()
    self.handlers.statements(self, node)
    self.printer:dec_indent()
    self.printer:emit('end')
  end
