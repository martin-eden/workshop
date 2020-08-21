local signatures = request('!.concepts.firmata.protocol.signatures')
local create_mode_byte = request('i2c_create_mode_byte')

return
  function(self, mode, device_id, restart_reads)
    restart_reads = restart_reads or false

    self:emit(
      signatures.i2c_request,
      device_id & 0x7F
    )

    local mode_byte = create_mode_byte(mode, device_id, restart_reads)
    self:emit(mode_byte)
  end
