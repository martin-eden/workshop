local signatures = request('!.concepts.firmata.protocol.signatures')

return
  function(self)
    self:emit(signatures.system_reset)
  end
