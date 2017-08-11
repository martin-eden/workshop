--[[
  Assures that <.start_dir> is somewhat meaningful.
]]

return
  function(self)
    if not self.start_dir or (self.start_dir == '') then
      self.start_dir = '.'
    end
    assert_string(self.start_dir)
  end
