local signatures = request('^.protocol.signatures')
local board = request('implementation.board')
local emit = request('implementation.emit')

return
  function(pin_number, pin_mode)
    board.assert_valid_pin_number(pin_number)
    board.assert_valid_pin_mode(pin_mode)
    emit(
      signatures.pin_mode,
      pin_number,
      pin_mode
    )
  end
