local multiliner =
  function(self, node)
    self:process_block_multiline('repeat', 'until', node.body)
    self.printer:add_text(' ')
    self:process_node(node.condition)
  end

return
  function(self, node)
    multiliner(self, node)
  end
