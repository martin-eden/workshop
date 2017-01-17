return
  function(self, s)
    self.text:add_text(s)
    if (#s > 0) then
      self.on_clean_line = false
    end
  end
