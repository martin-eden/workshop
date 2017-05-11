return
  function(self, str)
    if (str == self.move_down_str) then
      self:move_down()
    elseif (str == self.move_up_str) then
      self:move_up()
    else
      return self.levels[self.cur_level]:match_string(str)
    end
  end
