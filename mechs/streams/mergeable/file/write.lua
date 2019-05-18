return
  function(self, s)
    -- print(('raw_write [@%d, %d chars]'):format(self:get_position(), #s))
    self.assert_no_error(self.f:write(s))
  end
