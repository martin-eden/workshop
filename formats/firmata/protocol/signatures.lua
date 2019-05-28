return
  {
    toggle_analog_reporting =
      {
        [0x0] = 0xC0,
        [0x1] = 0xC1,
        [0x2] = 0xC2,
        [0x3] = 0xC3,
        [0x4] = 0xC4,
        [0x5] = 0xC5,
        [0x6] = 0xC6,
        [0x7] = 0xC7,
        [0x8] = 0xC8,
        [0x9] = 0xC9,
        [0xA] = 0xCA,
        [0xB] = 0xCB,
        [0xC] = 0xCC,
        [0xD] = 0xCD,
        [0xE] = 0xCE,
        [0xF] = 0xCF,
      },

    analog_report =
      {
        [0xE0] = 0x0,
        [0xE1] = 0x1,
        [0xE2] = 0x2,
        [0xE3] = 0x3,
        [0xE4] = 0x4,
        [0xE5] = 0x5,
        [0xE6] = 0x6,
        [0xE7] = 0x7,
        [0xE8] = 0x8,
        [0xE9] = 0x9,
        [0xEA] = 0xA,
        [0xEB] = 0xB,
        [0xEC] = 0xC,
        [0xED] = 0xD,
        [0xEE] = 0xE,
        [0xEF] = 0xF,
      },

    pin_mode = 0xF4,
    pin_value = 0xF5,
    protocol_version = 0xF9,

    sysex_start = 0xF0,
    sysex_end = 0xF7,

    system_reset = 0xFF,

    firmware = 0x79,
    query_analog_mapping = 0x69,
    response_analog_mapping = 0x6A,
    send_string = 0x71,

    i2c_request = 0x76,
    i2c_reply = 0x77,
    i2c_config = 0x78,
  }
