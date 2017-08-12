local exists = request('!.file.exists')
local safe_open = request('!.file.safe_open')

return
  function(self)
    assert_string(self.f_in_name)
    if not exists(self.f_in_name) then
      self:say(('File "%s" not found.'):format(self.f_in_name))
      return
    end

    assert_string(self.f_out_name)
    -- Test that <f_out_name> is writable:
    local f_out = safe_open(self.f_out_name, 'w')
    f_out:close()
  end
