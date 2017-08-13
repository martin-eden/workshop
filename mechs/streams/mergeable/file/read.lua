return
  function(self, num_positions)
    local s = self.f:read(num_positions)
    if s then
      return s, #s
    end
  end
