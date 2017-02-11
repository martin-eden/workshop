return
  function(self)
    local printer = self.printer
    printer:add_curline(', ')
    printer:request_clean_line()
  end
