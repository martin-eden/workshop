local signatures = request('!.formats.firmata.protocol.signatures')
local sysex_start = signatures.sysex_start
local sysex_end = signatures.sysex_end

local frame_regexp =
  ('^%c([%c-%c]+)%c'):
  format(sysex_start, 0x00, 0x7F, sysex_end)

return
  function(stream)
    return stream:match_regexp(frame_regexp)
  end
