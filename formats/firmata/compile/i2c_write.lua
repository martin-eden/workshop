local signatures = request('^.protocol.signatures')
local emit = request('implementation.emit')
local emit_bytes = request('implementation.emit_bytes')
local i2c_emit_request = request('implementation.i2c_emit_request')

return
  function(device_id, ...)
    emit(signatures.sysex_start)
    i2c_emit_request('write', device_id)
    emit_bytes(...)
    emit(signatures.sysex_end)
  end
