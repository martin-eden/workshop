--[[
  Set baud rate and non-blocking read mode for TTY device given by name.

  Non-blocking read means that if we do read(10) (reading ten bytes) and
  receive buffer has only five bytes, we wait up to <max_wait_time>
  seconds for more and then return bytes we have.
]]

return
  function(tty_name, max_wait_time, baud)
    assert_string(tty_name)

    max_wait_time = max_wait_time or 0.5
    -- "stty" accepts waiting time as tenths of seconds, so we multiply by 10:
    max_wait_time = math.floor(max_wait_time * 10)

    baud = baud or 57600

    local cmd =
      ('stty --file=%s %d raw time %d min 0 cs8 -echo -echoctl' ..
       ' -echoe -echok -echoke -icanon -icrnl -iexten -isig -ixon -opost'):
      -- ('stty --file=%s %d -echoctl raw time %d min 0 cs8'):
      format(tty_name, baud, max_wait_time)

    assert(os.execute(cmd))
  end
