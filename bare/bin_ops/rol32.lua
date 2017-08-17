return
  function(int_32, num_bits)
    int_32 = int_32 & 0xFFFFFFFF
    return
      ((int_32 << num_bits) | (int_32 >> (32 - num_bits))) & 0xFFFFFFFF
  end
