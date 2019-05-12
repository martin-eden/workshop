return
  function(self, new_position)
    new_position = math.max(new_position, 1)
    self.assert_no_error(self.f:seek('set', new_position - 1))
  end
