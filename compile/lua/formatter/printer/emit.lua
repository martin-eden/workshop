return
  function(self, s)
    if self.has_debt then
      self.cur_line:add(self:get_indent())
      self.has_debt = false
    end
    self.cur_line:add(s)
  end

