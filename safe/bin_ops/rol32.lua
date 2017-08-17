local rol = request('!.bare.bin_ops.rol32')

return
  function(n, num_bits)
    assert_integer(n)
    assert_integer(num_bits)
    assert((num_bits >= 0) and (num_bits <= 32))
    return rol(n, num_bits)
  end
