return
  function(self, s)
    self.lines[#self.lines] = (self.lines[#self.lines] or '') .. s
  end
