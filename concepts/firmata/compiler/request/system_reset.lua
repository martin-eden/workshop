local signatures = request('!.formats.firmata.protocol.signatures')

return
  function(self)
    self:emit(signatures.system_reset)
  end
