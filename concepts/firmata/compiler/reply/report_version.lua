local signatures = request('!.concepts.firmata.protocol.signatures')
local version = request('!.concepts.firmata.protocol.version')

return
  function(self)
    self:emit(
      signatures.sysex_start,
      signatures.firmware,
      version.major,
      version.minor
    )
    self:emit_string(version.file_name)
    self:emit(signatures.sysex_end)
  end
