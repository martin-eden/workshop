return
  function(tty_name, params)
    assert_string(tty_name)
    assert_string(params)
    local cmd =
      ('stty --file=%s %s'):format(tty_name, params)
    -- print(cmd)
    assert(os.execute(cmd))
  end
