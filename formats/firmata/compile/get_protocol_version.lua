local signatures = request('^.protocol.signatures')
local emit = request('implementation.emit')

return
  function()
    emit(signatures.protocol_version)
  end
