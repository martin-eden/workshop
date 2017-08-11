return
  function(self)
    local orig_pos = self:get_position()
    local result = self.f:seek('end')
    self:set_position(orig_pos)
    return result
  end
