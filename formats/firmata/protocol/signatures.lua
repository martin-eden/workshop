return
  {
    protocol_version = 0xF9,
    pin_mode = 0xF4,
    pin_value = 0xF5,

    sysex_start = 0xF0,
    sysex_end = 0xF7,

    firmware = 0x79,
    query_analog_mapping = 0x69,
    response_analog_mapping = 0x6A,
    send_string = 0x71,

    i2c_request = 0x76,
    i2c_reply = 0x77,
    i2c_config = 0x78,
  }
