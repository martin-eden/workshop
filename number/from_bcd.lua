local slice_bits = request('slice_bits')

return
  function(v)
    local high_digit = slice_bits(v, 4, 7)
    local low_digit = slice_bits(v, 0, 3)
    assert(high_digit <= 9)
    assert(low_digit <= 9)
    return high_digit * 10 + low_digit
  end
