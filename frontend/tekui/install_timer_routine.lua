local default_update_delta = 0.2

return
  function(app, timer_routine, update_delta)
    assert_function(timer_routine)
    update_delta = update_delta or default_update_delta
    assert_number(update_delta)

    local on_idle_func =
      function(app)
        local cur_time, last_time = 0, 0
        while true do
          cur_time = os.clock()
          if (cur_time - last_time >= update_delta) then
            timer_routine(app)
            last_time = cur_time
          end
          app:suspend()
        end
      end

    app:addCoroutine(on_idle_func, app)
  end
