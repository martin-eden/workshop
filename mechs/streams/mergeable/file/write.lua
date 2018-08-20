return
  function(self, s)
    -- print(('raw_write [@%d, %d chars]'):format(self:get_position(), #s))
    local is_ok, err_msg = self.f:write(s)
    assert(is_ok, err_msg)
  end
