return
  function(self, str)
    if (str == self.move_down_str) then
      self:move_down()
    elseif (str == self.move_up_str) then
      self:move_up()
    else
      self.levels[self.cur_level]:write_string(str)
    end
  end
