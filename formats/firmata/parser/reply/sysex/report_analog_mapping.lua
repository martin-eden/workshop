return
  function(self, chunk)
    local result =
      {
        analog_pins = {},
        num_pins = #chunk,
      }

    for i = 1, result.num_pins do
      local pin_index = i - 1
      local analog_index = chunk:sub(i, i):byte()
      if (analog_index ~= 127) then
        result.analog_pins[pin_index] = analog_index
      end
    end

    return result
  end
