local signatures = request('^.protocol.signatures')
local emit = request('implementation.emit')
local i2c_emit_request = request('implementation.i2c_emit_request')

return
  function(device_id)
    emit(signatures.sysex_start)
    i2c_emit_request('stop_reading', device_id)
    emit(signatures.sysex_end)
  end
