local signatures = request('!.concepts.firmata.protocol.signatures')

return
  function(self, pin_number)
    self:emit(
      signatures.sysex_start,
      signatures.query_pin_state,
      pin_number,
      signatures.sysex_end
    )
  end
