--[[
  Due implementation of Arduino counterpart you need to call
  this function to initialize I2C pins.
]]

local signatures = request('!.formats.firmata.protocol.signatures')
local assert_byte = request('!.number.assert_byte')
local emit = request('^.implementation.emit')
local emit_bytes = request('^.implementation.emit_bytes')

return
  function(delay_micros)
    delay_micros = delay_micros or 0
    assert_byte(delay_micros)

    emit(
      signatures.sysex_start,
      signatures.i2c_config
    )
    if (delay_micros > 0) then
      emit_bytes(delay_micros)
    end
    emit(signatures.sysex_end)
  end
