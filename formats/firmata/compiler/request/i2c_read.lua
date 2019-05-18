local assert_offset = request('!.formats.i2c.assert_offset')
local assert_num_bytes = request('!.formats.i2c.assert_num_bytes')
local emit = request('^.implementation.emit')
local emit_bytes = request('^.implementation.emit_bytes')
local i2c_emit_request = request('^.implementation.i2c_emit_request')
local signatures = request('!.formats.firmata.protocol.signatures')

return
  function(device_id, offset, num_bytes)
    assert_offset(offset)
    assert_num_bytes(num_bytes)

    emit(signatures.sysex_start)
    i2c_emit_request('read', device_id)
    emit_bytes(offset, num_bytes)
    emit(signatures.sysex_end)
  end
