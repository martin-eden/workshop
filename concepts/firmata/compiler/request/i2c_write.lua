local signatures = request('!.concepts.firmata.protocol.signatures')

return
  function(self, device_id, ...)
    self:emit(signatures.sysex_start)
    self:i2c_emit_request('write', device_id)
    self:emit_bytes(...)
    self:emit(signatures.sysex_end)
  end
