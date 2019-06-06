-- Set specified bit range in integer number to integer number.

local assert_bit_offs = request('assert_bit_offs')

return
  function(n, start_offs, end_offs, v)
    assert_integer(n)
    assert(v >= 0)
    assert_integer(start_offs)
    assert_bit_offs(start_offs)
    assert_integer(end_offs)
    assert_bit_offs(end_offs)
    assert(start_offs <= end_offs)
    assert_integer(v)

    local mask
    mask = (1 << (end_offs + 1)) - 1
    mask = mask & ~((1 << start_offs) - 1)
    mask = ~mask

    return (n & mask) | (v << start_offs)
  end
