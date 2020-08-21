return
  function(self, s)
    assert_string(s)
    self:emit_bytes(s:byte(1, -1))
  end
