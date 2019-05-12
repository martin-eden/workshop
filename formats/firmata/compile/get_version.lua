local signatures = request('^.protocol.signatures')
local emit = request('implementation.emit')

return
  function()
    emit(
      signatures.sysex_start,
      signatures.firmware,
      signatures.sysex_end
    )
  end
