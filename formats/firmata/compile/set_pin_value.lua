local signatures = request('^.protocol.signatures')
local board = request('implementation.board')
local assert_bit = request('!.number.assert_bit')
local emit = request('implementation.emit')

return
  function(pin_number, pin_value)
    board.assert_valid_pin_number(pin_number)
    assert_bit(pin_value)

    emit(
      signatures.pin_value,
      pin_number,
      pin_value
    )
  end
