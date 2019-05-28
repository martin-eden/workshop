local signatures = request('!.formats.firmata.protocol.signatures')
local version = request('!.formats.firmata.protocol.version')

return
  function(self)
    self:emit(
      signatures.protocol_version,
      version.major,
      version.minor
    )
  end
