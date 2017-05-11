return
  function(self)
    local cur_slot = self.levels[self.cur_level]:get_slot()
    if not is_table(cur_slot) then
      error('Trying to move down not in table slot.')
    end
    self.levels[self.cur_level]:set_next_position()
    self.cur_level = self.cur_level + 1
    self.levels[self.cur_level] = new(self.c_sequence)
    self.levels[self.cur_level]:init(cur_slot)
  end
