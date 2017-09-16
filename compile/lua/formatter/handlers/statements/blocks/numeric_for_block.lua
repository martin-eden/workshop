return
  function(self, node)
    self.printer:add_curline('for ')
    if not self:process_node(node.index) then
      return
    end
    self.printer:add_curline(' = ')
    if not self:process_node(node.start_val) then
      return
    end
    self.printer:add_curline(', ')
    if not self:process_node(node.end_val) then
      return
    end
    if node.increment then
      self.printer:add_curline(', ')
      if not self:process_node(node.increment) then
        return
      end
    end
    self.printer:add_curline(' ')
    return self:process_block_multiline('do', node.body, 'end')
  end
