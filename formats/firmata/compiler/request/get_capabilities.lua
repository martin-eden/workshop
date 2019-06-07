local signatures = request('!.formats.firmata.protocol.signatures')

return
  function(self)
    self:emit(
      signatures.sysex_start,
      signatures.query_capabilities,
      signatures.sysex_end
    )
  end
