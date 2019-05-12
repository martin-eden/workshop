return
  function(self)
    local seek_pos = self.assert_no_error(self.f:seek())
    return seek_pos + 1
  end
