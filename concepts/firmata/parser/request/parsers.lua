local signatures = request('!.concepts.firmata.protocol.signatures')

return
  {
    [signatures.protocol_version] =
      {
        name = 'get_protocol_version',
        parser = request('get_protocol_version'),
      },
    [signatures.pin_mode] =
      {
        name = 'set_pin_mode',
        parser = request('set_pin_mode'),
      },
    [signatures.pin_value] =
      {
        name = 'set_pin_value',
        parser = request('set_pin_value'),
      },
    [signatures.system_reset] =
      {
        name = 'system_reset',
        parser = request('system_reset'),
      },
  }
