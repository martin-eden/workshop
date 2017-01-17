local multiliner =
  function(self, node)
    self.printer:request_empty_line()
    self.printer:add_text('local function ')
    self:process_node(node.dotted_name)
    self:process_node(node.params)
    self:process_block_multiline(nil, 'end', node.body)
    self.printer:request_empty_line()
  end

return
  function(self, node)
    multiliner(self, node)
  end
