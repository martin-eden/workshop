local signatures = request('!.formats.firmata.protocol.signatures')
local assert_offset = request('!.formats.i2c.assert_offset')
local assert_num_bytes = request('!.formats.i2c.assert_num_bytes')

return
  function(self, device_id, offset, num_bytes)
    assert_offset(offset)
    assert_num_bytes(num_bytes)

    self:emit(signatures.sysex_start)
    self:i2c_emit_request('read', device_id)
    self:emit_bytes(offset, num_bytes)
    self:emit(signatures.sysex_end)
  end
