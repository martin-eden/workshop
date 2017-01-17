return
  function(self, node)
    self.printer:add_text('(')
    self:process_list(node, ', ')
    self.printer:add_text(')')
  end
