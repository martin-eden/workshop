local firmata = request('!.formats.firmata.protocol.interface')
local assert_valid_pin_number =
  request('!.formats.arduino_uno.assert_valid_pin_number')

return
  function(self, pin_number, mode_name)
    assert_valid_pin_number(pin_number)
    firmata.assert_valid_pin_mode(mode_name)

    local mode_id = firmata.pin_modes[mode_name]

    self:emit(
      firmata.signatures.pin_mode,
      pin_number,
      mode_id
    )
  end
