return
  function(self, node)
    self.printer:emit('if ')
    self:process_node(node.if_part.condition)
    self.printer:emit(' then')
    self.printer:emit_nl()
    self.printer:inc_indent()
    self:process_node(node.if_part.body)
    self.printer:dec_indent()
    if node.elseif_parts then
      for i = 1, #node.elseif_parts do
        local part = node.elseif_parts[i]
        self.printer:emit('elseif ')
        self:process_node(part.condition)
        self.printer:emit(' then')
        self.printer:emit_nl()
        self.printer:inc_indent()
        self:process_node(part.body)
        self.printer:dec_indent()
      end
    end
    if node.else_part then
      self.printer:emit('else')
      self.printer:emit_nl()
      self.printer:inc_indent()
      self:process_node(node.else_part.body)
      self.printer:dec_indent()
    end
    self.printer:emit('end')
  end
