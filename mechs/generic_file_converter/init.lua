local safe_open = request('^.^.file.safe_open')

return
  function(self)
    if (self.f_in_name == '') or (self.f_out_name == '') then
      print('Usage: <f_in> <f_out>')
    end

    -- Test that <f_out_name> is writable:
    local f_out = safe_open(self.f_out_name, 'w')
    f_out:close()
  end
