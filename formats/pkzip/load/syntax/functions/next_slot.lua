return
  function(in_stream, out_stream)
    local int_data = out_stream.int_data
    int_data.slots_pos = int_data.slots_pos + 1
    return int_data.slots[int_data.slots_pos]
  end
