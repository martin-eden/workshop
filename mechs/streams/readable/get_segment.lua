return
  function(self, start, len)
    self:set_position(start)
    return self:block_read(len)
  end
