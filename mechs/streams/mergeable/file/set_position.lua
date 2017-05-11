return
  function(self, new_position)
    new_position = math.max(new_position, 0)
    new_position = math.min(new_position, self.f:seek('end'))
    self.f:seek('set', new_position)
  end
