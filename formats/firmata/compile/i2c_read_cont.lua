local signatures = request('^.protocol.signatures')
local assert_offset = request('!.formats.i2c.assert_offset')
local assert_num_bytes = request('!.formats.i2c.assert_num_bytes')
local emit = request('implementation.emit')
local emit_bytes = request('implementation.emit_bytes')
local i2c_emit_request = request('implementation.i2c_emit_request')

return
  function(device_id, offset, num_bytes)
    assert_offset(offset)
    assert_num_bytes(num_bytes)

    emit(signatures.sysex_start)
    local restart_reads = true
    i2c_emit_request('read_continiously', device_id, restart_reads)
    emit_bytes(offset, num_bytes)
    emit(signatures.sysex_end)
  end