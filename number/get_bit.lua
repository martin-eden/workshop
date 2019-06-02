local assert_bit_offs = request('assert_bit_offs')

return
  function(n, bit_offs)
    assert_integer(n)
    assert_integer(bit_offs)
    assert_bit_offs(bit_offs)

    return (n & (1 << bit_offs) ~= 0)
  end
