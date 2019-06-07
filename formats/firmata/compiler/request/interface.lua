return
  {
    system_reset = request('system_reset'),

    get_version = request('get_version'),
    get_protocol_version = request('get_protocol_version'),

    get_analog_mapping = request('get_analog_mapping'),

    set_pin_mode = request('set_pin_mode'),
    set_pin_value = request('set_pin_value'),
    set_pin_value_long = request('set_pin_value_long'),

    enable_analog_reporting = request('enable_analog_reporting'),
    disable_analog_reporting = request('disable_analog_reporting'),
    toggle_analog_reporting = request('toggle_analog_reporting'),

    enable_digital_reporting = request('enable_digital_reporting'),
    disable_digital_reporting = request('disable_digital_reporting'),
    toggle_digital_reporting = request('toggle_digital_reporting'),

    set_sampling_interval = request('set_sampling_interval'),

    i2c_config = request('i2c_config'),
    i2c_read = request('i2c_read'),
    i2c_read_cont = request('i2c_read_cont'),
    i2c_read_stop = request('i2c_read_stop'),
    i2c_write = request('i2c_write'),
  }
