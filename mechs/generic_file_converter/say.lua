local msg_with_time = request('!.system.msg_with_time')

return
  function(self, s)
    msg_with_time(s)
  end
