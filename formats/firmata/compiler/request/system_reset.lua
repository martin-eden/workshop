local signatures = request('!.formats.firmata.protocol.signatures')
local emit = request('^.implementation.emit')

return
  function()
    emit(signatures.system_reset)
  end
