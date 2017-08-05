local represent_time = request('^.number.represent_time')

local last_time

return
  function(s)
    local cur_time = os.clock()
    if last_time then
      local time_passed = represent_time(cur_time - last_time)
      io.stderr:write((' [%s]\n'):format(time_passed))
    end
    io.stderr:write(s)
    last_time = cur_time
  end
