local signatures = request('!.formats.firmata.protocol.signatures')

return
  function(self, chunk, type_id)
    if (#chunk < 2) then
      return
    end

    local port_index = signatures.digital_report[type_id]
    local value = self:to_word(chunk:byte(1, 2))

    local result =
      {
        port_index = port_index,
        pins = {}
      }

    local base_offset = port_index * 8
    for pin_offset = 0, 7 do
      result.pins[base_offset + pin_offset] =
        (value & (1 << pin_offset) ~= 0)
    end

    return result
  end
