return
  function(self, node)
    local printer = self.printer
    if (#node == 0) then
      printer:add_text('{}')
      return
    end
    printer:add_text('{')
    printer:close_line()
    printer:inc_indent()
    for i = 1, #node do
      local key, value = node[i].key, node[i].value
      if key then
        self:process_node(key)
        printer:add_text(' = ')
      end
      self:process_node(value)
      printer:add_text(';')
      printer:close_line()
    end
    printer:dec_indent()
    printer:add_text('}')
  end
