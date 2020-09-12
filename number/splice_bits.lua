-- Insert given integer into specified bit range.

local assert_bit_offs = request('assert_bit_offs')

return
  function(v, start_offs, end_offs, n)
    n = is_nil(n) and 0 or n
    assert_integer(n)
    assert_integer(v)
    assert(v >= 0)
    assert_integer(start_offs)
    assert_bit_offs(start_offs)
    assert_integer(end_offs)
    assert_bit_offs(end_offs)
    assert(start_offs <= end_offs)
    if ((v << start_offs) > (1 << (end_offs + 1))) then
      error(
        ('Value 0x%X is too large to fit given bit range [%d, %d].'):
        format(v, start_offs, end_offs)
      )
    end


    local mask
    -- start_offs: 2, end_offs: 5
    mask = (1 << (end_offs + 1)) - 1
    -- mask: 111111
    mask = mask & ~((1 << start_offs) - 1)
    -- mask: 111100
    mask = ~mask
    -- mask: 000011

    return (n & mask) | (v << start_offs)
  end
