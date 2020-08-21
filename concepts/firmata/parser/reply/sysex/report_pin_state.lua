local mode_names = request('!.formats.firmata.protocol.mode_names')

return
  function(self, chunk)
    local value = 0
    for i = #chunk, 3, -1 do
      value = (value << 7) | chunk:byte(i)
    end

    return
      {
        pin = chunk:byte(1),
        mode = mode_names[chunk:byte(2)],
        state = value,
      }
  end
