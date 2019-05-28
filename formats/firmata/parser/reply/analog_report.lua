local signatures = request('!.formats.firmata.protocol.signatures')

return
  function(self, chunk, type_id)
    if (#chunk < 2) then
      return
    end

    return
      {
        analog_pin = signatures.analog_report[type_id],
        value = self:to_word(chunk:byte(1, 2))
      }
  end
