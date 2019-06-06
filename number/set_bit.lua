local assert_bit_offs = request('assert_bit_offs')

return
  function(n, bit_offs, v)
    assert_integer(n)
    assert_integer(bit_offs)
    assert_bit_offs(bit_offs)
    assert_boolean(v)

    if v then
      n = n | (1 << bit_offs)
    else
      n = n & ~(1 << bit_offs)
    end

    return n
  end
