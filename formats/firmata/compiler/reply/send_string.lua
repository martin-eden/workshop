local signatures = request('!.formats.firmata.protocol.signatures')

return
  function(self, s)
    assert_string(s)
    local max_len_msg =
      'Maximum string length is limited to 30 characters by Arduino part.'
    assert(#s <= 30, max_len_msg)
    self:emit(
      signatures.sysex_start,
      signatures.send_string
    )
    self:emit_string(s)
    self:emit(signatures.sysex_end)
  end
