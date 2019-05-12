local signatures = request('^.protocol.signatures')
local emit = request('implementation.emit')
local emit_string = request('implementation.emit_string')

return
  function(s)
    assert_string(s)
    local max_len_msg =
      'Maximum string length is limited to 30 characters by Arduino part.'
    assert(#s <= 30, max_len_msg)
    emit(
      signatures.sysex_start,
      signatures.send_string
    )
    emit_string(s)
    emit(signatures.sysex_end)
  end
