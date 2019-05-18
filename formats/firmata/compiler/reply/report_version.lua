local signatures = request('!.formats.firmata.protocol.signatures')
local version = request('!.formats.firmata.protocol.version')
local emit = request('^.implementation.emit')
local emit_string = request('^.implementation.emit_string')

return
  function()
    emit(
      signatures.sysex_start,
      signatures.firmware,
      version.major,
      version.minor
    )
    emit_string(version.file_name)
    emit(signatures.sysex_end)
  end
