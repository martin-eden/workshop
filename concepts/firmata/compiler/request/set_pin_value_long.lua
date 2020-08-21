local signatures = request('!.concepts.firmata.protocol.signatures')
local assert_valid_pin_number =
  request('!.concepts.arduino_uno.assert_valid_pin_number')
local slice_bits = request('!.number.slice_bits')
local get_msb = request('!.number.get_msb')

return
  function(self, pin_number, value)
    assert_valid_pin_number(pin_number)

    local msb = get_msb(value)
    self:emit(
      signatures.sysex_start,
      signatures.set_pin_value_long,
      pin_number
    )
    local highest_bit = 0
    repeat
      self:emit(slice_bits(value, highest_bit, highest_bit + 6))
      highest_bit = highest_bit + 7
    until (highest_bit >= msb)
    self:emit(signatures.sysex_end)
  end
