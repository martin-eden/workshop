return
  function(in_stream, out_stream)
    local int_data = out_stream.int_data
    local slot_rec = int_data.slots[int_data.slots_pos]
    in_stream:set_relative_position(slot_rec.length)
    return true
  end
