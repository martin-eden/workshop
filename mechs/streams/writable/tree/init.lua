return
  function(self)
    self.levels = {}
    self.cur_level = 1
    self.levels[self.cur_level] = new(self.c_sequence)
    self.levels[self.cur_level]:init()
  end
