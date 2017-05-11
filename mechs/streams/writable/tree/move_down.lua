return
  function(self)
    self.levels[self.cur_level] = new(self.c_sequence)
    self.levels[self.cur_level]:init()
    self.cur_level = self.cur_level + 1
  end
