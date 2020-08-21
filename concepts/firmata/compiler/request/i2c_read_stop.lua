local signatures = request('!.formats.firmata.protocol.signatures')

return
  function(self, device_id)
    self:emit(signatures.sysex_start)
    self:i2c_emit_request('stop_reading', device_id)
    self:emit(signatures.sysex_end)
  end
