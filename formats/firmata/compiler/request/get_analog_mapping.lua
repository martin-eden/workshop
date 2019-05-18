local signatures = request('!.formats.firmata.protocol.signatures')
local emit = request('^.implementation.emit')

return
  function()
    emit(
      signatures.sysex_start,
      signatures.query_analog_mapping,
      signatures.sysex_end
    )
  end
