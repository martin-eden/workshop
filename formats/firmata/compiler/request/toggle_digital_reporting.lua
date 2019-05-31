local signatures = request('!.formats.firmata.protocol.signatures')
local assert_bit = request('!.number.assert_bit')

return
  function(self, port_index, state)
    assert_bit(state)
    self:emit(signatures.toggle_digital_reporting[port_index], state)
  end
