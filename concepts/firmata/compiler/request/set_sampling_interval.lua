local signatures = request('!.formats.firmata.protocol.signatures')
local slice_bits = request('!.number.slice_bits')

return
  function(self, delta_ms)
    self:emit(
      signatures.sysex_start,
      signatures.set_sampling_interval,
      slice_bits(delta_ms, 0, 6),
      slice_bits(delta_ms, 7, 14),
      signatures.sysex_end
    )
  end
