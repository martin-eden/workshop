return
  function(self, num_positions)
    local s = self.f:read(num_positions)
    return s, #s
  end
