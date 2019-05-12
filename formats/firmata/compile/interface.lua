return
  {
    system_reset = request('system_reset'),

    get_version = request('get_version'),
    report_version = request('report_version'),

    get_protocol_version = request('get_protocol_version'),
    report_protocol_version = request('report_protocol_version'),

    get_analog_mapping = request('get_analog_mapping'),
    report_analog_mapping = request('report_analog_mapping'),

    send_string = request('send_string'),

    set_pin_mode = request('set_pin_mode'),
    set_pin_value = request('set_pin_value'),

    i2c_config = request('i2c_config'),
    i2c_read = request('i2c_read'),
    i2c_read_cont = request('i2c_read_cont'),
    i2c_read_stop = request('i2c_read_stop'),
    i2c_reply = request('i2c_reply'),
    i2c_write = request('i2c_write'),
  }
