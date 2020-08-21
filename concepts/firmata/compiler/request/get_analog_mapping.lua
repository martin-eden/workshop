local signatures = request('!.formats.firmata.protocol.signatures')

return
  function(self)
    self:emit(
      signatures.sysex_start,
      signatures.query_analog_mapping,
      signatures.sysex_end
    )
  end
