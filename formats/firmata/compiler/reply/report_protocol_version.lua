local signatures = request('!.formats.firmata.protocol.signatures')
local version = request('!.formats.firmata.protocol.version')
local emit = request('^.compile.implementation.emit')

return
  function()
    emit(
      signatures.protocol_version,
      version.major,
      version.minor
    )
  end
