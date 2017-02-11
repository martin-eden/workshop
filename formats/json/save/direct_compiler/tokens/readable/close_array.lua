return
  function(self)
    local printer = self.printer
    printer:request_clean_line()
    printer:dec_indent()
    printer:add_curline(']')
  end
