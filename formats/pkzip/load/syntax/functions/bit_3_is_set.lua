return
  function(in_stream, out_stream)
    local bit_flag = out_stream.int_data.bit_flag
    return (bit_flag & (1 << 3) ~= 0)
  end
