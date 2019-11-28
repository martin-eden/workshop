local save_port_params =
  function(tty_name)
    assert_string(tty_name)
    local cmd =
      ('stty --file=%s --save'):format(tty_name)
    local f_output = assert(io.popen(cmd))
    local result = f_output:read('l')
    f_output:close()
    -- print(result)
    return result
  end

local load_port_params =
  function(tty_name, params)
    assert_string(tty_name)
    assert_string(params)
    local cmd =
      ('stty --file=%s %s'):format(tty_name, params)
    -- print(cmd)
    assert(os.execute(cmd))
  end

local set_non_blocking_read =
  function(tty_name, max_wait_time, baud)
    assert_string(tty_name)

    max_wait_time = max_wait_time or 0.5
    max_wait_time = max_wait_time * 10
    max_wait_time = max_wait_time // 1

    baud = baud or 57600

    local cmd =
      ('stty --file=%s %d raw time %d min 0 cs8 -echo -echoctl -echoe -echok -echoke -icanon -icrnl -iexten -isig -ixon -opost'):
      -- ('stty --file=%s %d -echoctl raw time %d min 0 cs8'):
      format(tty_name, baud, max_wait_time)
    -- print(cmd)

    assert(os.execute(cmd))
  end

return
  {
    save_port_params = save_port_params,
    load_port_params = load_port_params,
    set_non_blocking_read = set_non_blocking_read,
  }
