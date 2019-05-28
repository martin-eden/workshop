local signatures = request('!.formats.firmata.protocol.signatures')

return
  function(self)
    self:emit(
      signatures.sysex_start,
      signatures.firmware,
      signatures.sysex_end
    )
  end
