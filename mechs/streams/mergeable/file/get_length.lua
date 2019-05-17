return
  function(self)
    local orig_pos = self:get_position()
    local result = self.assert_no_error(self.f:seek('end'))
    self:set_position(orig_pos)
    return result
  end
