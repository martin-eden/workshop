local signatures = request('!.concepts.firmata.protocol.signatures')
local sysex_start = signatures.sysex_start
local sysex_end = signatures.sysex_end

local sysex_frame_regexp =
  ('^%c([%c-%c]+)%c'):
  format(sysex_start, 0x00, 0x7F, sysex_end)

return
  function(self)
    local chunk = self.stream:match_regexp(sysex_frame_regexp)

    if not chunk then
      return
    end

    local type_id = chunk:byte(1)
    local data

    -- (1)
    if (type_id == 0) then
      assert(#chunk >= 3)
      type_id = (chunk:byte(2) << 8) | byte(3)
      data = chunk:sub(4)
    else
      -- Ids 0x7E, 0x7F are used in Midi, so are forbidden in Firmata.
      assert(type_id <= 0x7D)
      data = chunk:sub(2)
    end

    return type_id, data
  end

--[[
  [1]:
    Zero id means "extended id" in next two 7-bit bytes.
    Byte order is MSB. 8-bit bytes with zero 8th bit.
    Jeff Hoefs referred MIDI system as Firmata parent:

      https://www.midi.org/specifications-old/item/manufacturer-id-numbers
]]
