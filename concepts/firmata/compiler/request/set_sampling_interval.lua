local signatures = request('!.concepts.firmata.protocol.signatures')
local get_bits = request('!.number.get_bits')

return
  function(self, delta_ms)
    self:emit(
      signatures.sysex_start,
      signatures.set_sampling_interval,
      get_bits(delta_ms, 0, 6),
      get_bits(delta_ms, 7, 14),
      signatures.sysex_end
    )
  end
