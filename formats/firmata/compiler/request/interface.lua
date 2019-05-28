return
  {
    system_reset = request('system_reset'),

    get_version = request('get_version'),
    get_protocol_version = request('get_protocol_version'),

    get_analog_mapping = request('get_analog_mapping'),

    set_pin_mode = request('set_pin_mode'),
    set_pin_value = request('set_pin_value'),

    enable_analog_reporting = request('enable_analog_reporting'),
    disable_analog_reporting = request('disable_analog_reporting'),
    toggle_analog_reporting = request('toggle_analog_reporting'),

    i2c_config = request('i2c_config'),
    i2c_read = request('i2c_read'),
    i2c_read_cont = request('i2c_read_cont'),
    i2c_read_stop = request('i2c_read_stop'),
    i2c_write = request('i2c_write'),
  }
