return
  function(in_stream, out_stream)
    local int_data = out_stream.int_data
    local slot_rec = int_data.slots[int_data.slots_pos]
    in_stream:set_position(slot_rec.offset + 1)
    return true
  end
