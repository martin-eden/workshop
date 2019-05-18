local signatures = request('!.formats.firmata.protocol.signatures')
local board = request('!.formats.arduino_uno.interface')
local emit = request('^.implementation.emit')

return
  function()
    emit(
      signatures.sysex_start,
      signatures.response_analog_mapping
    )
    for pin_number = 0, (board.num_pins - 1) do
      local analog_index = board.get_pin_analog_index(pin_number) or 127
      emit(analog_index)
    end
    emit(signatures.sysex_end)
  end
