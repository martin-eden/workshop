local assert_device_id = request('!.formats.i2c.assert_device_id')
local assert_offset = request('!.formats.i2c.assert_offset')
local signatures = request('!.formats.firmata.protocol.signatures')
local emit = request('^.implementation.emit')
local emit_bytes = request('^.implementation.emit_bytes')

return
  function(device_id, offset, ...)
    assert_device_id(device_id)
    assert_offset(offset)

    emit(
      signatures.sysex_start,
      signatures.i2c_reply,
      device_id & 0x7F,
      device_id >> 7
    )
    emit_bytes(offset, ...)
    emit(signatures.sysex_end)
  end
