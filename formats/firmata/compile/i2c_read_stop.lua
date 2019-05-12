local signatures = request('^.protocol.signatures')
local assert_offset = request('!.formats.i2c.assert_offset')
local assert_num_bytes = request('!.formats.i2c.assert_num_bytes')
local emit = request('implementation.emit')
local i2c_emit_request = request('implementation.i2c_emit_request')

return
  function(device_id, offset)
    assert_offset(offset)

    emit(signatures.sysex_start)
    i2c_emit_request('stop_reading', device_id)
    emit(signatures.sysex_end)
  end
