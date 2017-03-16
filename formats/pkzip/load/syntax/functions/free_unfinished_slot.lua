return
  function(in_stream, out_stream)
    local int_data = out_stream.int_data
    if (int_data.slots_pos > 0) then
      int_data.slots[int_data.slots_pos] = nil
      int_data.slots_pos = int_data.slots_pos - 1
    end
    return true
  end
