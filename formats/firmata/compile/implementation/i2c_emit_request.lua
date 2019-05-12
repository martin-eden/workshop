local signatures = request('!.formats.firmata.protocol.signatures')
local emit = request('emit')
local create_mode_byte = request('i2c_create_mode_byte')

return
  function(mode, device_id, restart_reads)
    restart_reads = restart_reads or false

    emit(
      signatures.i2c_request,
      device_id & 0x7F
    )

    local mode_byte = create_mode_byte(mode, device_id, restart_reads)
    emit(mode_byte)
  end
