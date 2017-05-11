return
  function(self)
    if (self.levels == 1) then
      error('Trying to move up from root level.')
    end
    self.levels[self.cur_level] = nil
    self.cur_level = self.cur_level - 1
  end
