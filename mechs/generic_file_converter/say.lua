local print_msg_with_time = request('!.system.print_msg_with_time')

return
  function(self, s)
    print_msg_with_time(s)
  end
