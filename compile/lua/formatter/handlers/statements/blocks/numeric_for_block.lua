local multiliner =
  function(self, node)
    self.printer:add_text('for ')
    self:process_node(node.index)
    self.printer:add_text(' = ')
    self:process_node(node.start_val)
    self.printer:add_text(', ')
    self:process_node(node.end_val)
    if node.increment then
      self.printer:add_text(', ')
      self:process_node(node.increment)
    end
    self.printer:add_text(' ')
    self:process_block_multiline('do', 'end', node.body)
  end

return
  function(self, node)
    multiliner(self, node)
  end
