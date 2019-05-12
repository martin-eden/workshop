local signatures = request('^.protocol.signatures')
local version = request('^.protocol.version')
local emit = request('implementation.emit')

return
  function()
    emit(
      signatures.protocol_version,
      version.major,
      version.minor
    )
  end
