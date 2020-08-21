local signatures = request('!.concepts.firmata.protocol.signatures')
local assert_bit = request('!.number.assert_bit')

return
  function(self, analog_pin, state)
    assert_bit(state)
    self:emit(signatures.toggle_analog_reporting[analog_pin], state)
  end
