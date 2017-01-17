local oneliner =
  function(self, node)
    self.printer:add_text('local ')
    self:process_node(node.name_list)
    if node.val_list then
      self.printer:add_text(' = ')
      self:process_node(node.val_list)
    end
  end

local multiliner =
  function(self, node)
    local printer = self.printer
    printer:add_text('local ')
    self:process_node(node.name_list)
    if node.val_list then
      printer:add_text(' =')
      printer:close_line()
      printer:inc_indent()
      self:process_node(node.val_list)
      printer:dec_indent()
    end
  end

local variants =
  {
    {multiliner, is_multiline = true},
    oneliner,
  }

return
  function(self, node)
    self:variate(variants, node)
  end
