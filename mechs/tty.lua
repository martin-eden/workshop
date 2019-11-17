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
  function(tty_name, sleep_time, baud)
    assert_string(tty_name)
    baud = baud or 57600
    sleep_time = sleep_time or 0.5
    sleep_time = sleep_time * 10
    sleep_time = sleep_time // 1
    local cmd =
      ('stty --file=%s cs8 raw min 0 time %d %d'):
      format(tty_name, sleep_time, baud)
    -- print(cmd)
    assert(os.execute(cmd))
  end

return
  {
    save_port_params = save_port_params,
    load_port_params = load_port_params,
    set_non_blocking_read = set_non_blocking_read,
  }
