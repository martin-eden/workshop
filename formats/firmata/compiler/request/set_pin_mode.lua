local signatures = request('!.formats.firmata.protocol.signatures')
local assert_valid_pin_number =
  request('!.formats.arduino_uno.assert_valid_pin_number')
local assert_valid_pin_mode =
  request('!.formats.firmata.protocol.assert_valid_pin_mode')
local emit = request('^.implementation.emit')

return
  function(pin_number, pin_mode)
    assert_valid_pin_number(pin_number)
    assert_valid_pin_mode(pin_mode)
    emit(
      signatures.pin_mode,
      pin_number,
      pin_mode
    )
  end
