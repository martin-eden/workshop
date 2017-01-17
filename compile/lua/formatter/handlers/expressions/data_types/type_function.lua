local multiliner =
  function(self, node)
    self.printer:add_text('function')
    self:process_node(node.params)
    self:process_block_multiline(nil, 'end', node.body)
  end

return
  function(self, node)
    multiliner(self, node)
  end
