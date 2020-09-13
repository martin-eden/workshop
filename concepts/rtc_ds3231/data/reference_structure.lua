--[[
  Parsed data structure template.

  Used at compilation to verify/validate data.

  Exact key values are not important. But their type IS.
]]

return
  {
    moment =
      {
        second = 0,
        minute = 0,
        hour = 0,
        dow = 0,
        date = 0,
        month = 0,
        year = 0,
      },
    alarm_1 =
      {
        ignore_second = false,
        second = 0,
        ignore_minute = false,
        minute = 0,
        ignore_hour = false,
        store_hour_in_12h = false,
        hour = 0,
        ignore_date_dow = false,
        is_date_not_dow = false,
        date_dow = 0,
        enabled = false,
        occurred = false,
      },
    alarm_2 =
      {
        ignore_minute = false,
        minute = 0,
        ignore_hour = false,
        store_hour_in_12h = false,
        hour = 0,
        ignore_date_dow = false,
        is_date_not_dow = false,
        date_dow = 0,
        enabled = false,
        occurred = false,
      },
    output_alarms_not_wave = false,
    wave_freq = 0,
    get_temperature = false,
    at_battery =
      {
        allow_wave_output = false,
        stop_clock = false,
        clock_was_stopped = false,
      },
    is_busy = false,
    enable_wave_32k = false,
    clock_speed = 0,
    temperature = 0.0,
  }
