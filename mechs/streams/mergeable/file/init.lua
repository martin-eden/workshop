return
  function(self, f)
    local f_type = io.type(f)
    if (f_type ~= 'file') then
      error(
        ('Wrong <f> type: "%s" while "%s" awaited.'):format(f_type, 'file'), 2
      )
    end
    self.f = f
    self:original_init()
  end
