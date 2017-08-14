return
  function(self, num_positions)
    -- print(('raw_read [%d, %d]'):format(self:get_position(), num_positions))
    local s = self.f:read(num_positions)
    if s then
      return s, #s
    end
  end
