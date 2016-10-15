return
  function(self, node)
    self.printer:emit_nl()
    self.printer:emit('local function ')
    self:process_node(node.dotted_name)
    self:process_node(node.params)
    self.printer:emit_nl()
    self.printer:inc_indent()
    self:process_node(node.body)
    self.printer:dec_indent()
    self.printer:emit('end')
  end
