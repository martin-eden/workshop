--[[
  Due implementation of Arduino counterpart you need to call
  this function to initialize I2C pins.

  Beware: on Arduino Uno it changes mode of pins A4, A5. Those
  pins used as SDA, SCL.
]]

local signatures = request('!.formats.firmata.protocol.signatures')
local assert_byte = request('!.number.assert_byte')

return
  function(self, delay_micros)
    delay_micros = delay_micros or 0
    assert_byte(delay_micros)

    self:emit(
      signatures.sysex_start,
      signatures.i2c_config
    )
    if (delay_micros > 0) then
      self:emit_bytes(delay_micros)
    end
    self:emit(signatures.sysex_end)
  end
