local signatures = request('!.formats.firmata.protocol.signatures')
local assert_bit = request('!.number.assert_bit')
local assert_valid_pin_number =
  request('!.formats.arduino_uno.assert_valid_pin_number')
local emit = request('^.implementation.emit')

return
  function(pin_number, pin_value)
    assert_valid_pin_number(pin_number)
    assert_bit(pin_value)

    emit(
      signatures.pin_value,
      pin_number,
      pin_value
    )
  end
