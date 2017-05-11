return
  function(self)
    if (self.levels == 1) then
      error('Trying to move up from root level.')
    end
    self.cur_level = self.cur_level - 1
    self.levels[self.cur_level]:set_next_position()
  end
