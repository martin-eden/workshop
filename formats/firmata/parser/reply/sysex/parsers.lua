local signatures = request('!.formats.firmata.protocol.signatures')

return
  {
    [signatures.firmware] =
      {
        name = 'report_version',
        parser = request('report_version'),
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
