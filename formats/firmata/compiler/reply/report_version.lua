local signatures = request('!.formats.firmata.protocol.signatures')
local version = request('!.formats.firmata.protocol.version')

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
