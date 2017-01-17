return
  function(self)
    local prev_line = self.text.lines[#self.text.lines - 1]
    if (prev_line ~= '') then
      self:request_clean_line()
      self:close_line()
    end
  end
