return
  function(int_32, num_bits)
    int_32 = int_32 & 0xffffffff
    int_32 = (int_32 << num_bits) | (int_32 >> (32 - num_bits))
    int_32 = int_32 & 0xffffffff
    return int_32
  end
