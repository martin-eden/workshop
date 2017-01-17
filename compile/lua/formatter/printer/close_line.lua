return
  function(self)
    self.text:add_line()
    self.on_clean_line = true
    self:update_indent()
  end
