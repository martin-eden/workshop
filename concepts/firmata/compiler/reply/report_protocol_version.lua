local signatures = request('!.concepts.firmata.protocol.signatures')
local version = request('!.concepts.firmata.protocol.version')

return
  function(self)
    self:emit(
      signatures.protocol_version,
      version.major,
      version.minor
    )
  end
