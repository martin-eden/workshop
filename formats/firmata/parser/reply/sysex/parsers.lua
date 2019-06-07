local signatures = request('!.formats.firmata.protocol.signatures')

return
  {
    [signatures.firmware] =
      {
        name = 'report_version',
        parser = request('report_version'),
      },
    [signatures.report_analog_mapping] =
      {
        name = 'analog_mapping',
        parser = request('report_analog_mapping'),
      },
    [signatures.report_capabilities] =
      {
        name = 'pin_capabilities',
        parser = request('report_capabilities'),
      },
    [signatures.send_string] =
      {
        name = 'send_string',
        parser = request('send_string'),
      },
    [signatures.i2c_reply] =
      {
        name = 'i2c_reply',
        parser = request('i2c_reply'),
      },
  }
