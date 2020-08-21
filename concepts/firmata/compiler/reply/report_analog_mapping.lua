local signatures = request('!.concepts.firmata.protocol.signatures')
local board = request('!.concepts.arduino_uno.interface')

return
  function(self)
    self:emit(
      signatures.sysex_start,
      signatures.report_analog_mapping
    )
    for pin_number = 0, (board.num_pins - 1) do
      local analog_index = board.get_pin_analog_index(pin_number) or 127
      self:emit(analog_index)
    end
    self:emit(signatures.sysex_end)
  end
