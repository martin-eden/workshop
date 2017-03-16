local read_uint = request('read_uint')

return
  function(in_stream, out_stream)
    local int_data = out_stream.int_data
    local slot_rec = int_data.slots[int_data.slots_pos]
    slot_rec.offset = read_uint(in_stream, 4)
    return true
  end
