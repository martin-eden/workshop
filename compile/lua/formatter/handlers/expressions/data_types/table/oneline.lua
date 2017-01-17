return
  function(self, node)
    self.printer:add_text('{')
    for i = 1, #node do
      if (i > 1) then
        self.printer:add_text(', ')
      end
      local key, value = node[i].key, node[i].value
      if key then
        self:process_node(key)
        self.printer:add_text(' = ')
      end
      self:process_node(value)
    end
    self.printer:add_text('}')
  end
