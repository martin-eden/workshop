local signatures = request('^.protocol.signatures')
local emit = request('implementation.emit')

return
  function()
    emit(signatures.system_reset)
  end
