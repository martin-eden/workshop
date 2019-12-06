local slice_bits = request('slice_bits')

return
  function(v)
    assert(v >= 0)
    local high_digit = slice_bits(v, 4, 7)
    local low_digit = slice_bits(v, 0, 3)
    if not ((high_digit <= 9) and (low_digit <= 9)) then
      local err_msg =
        ("Number 0x%02X can't be interpreted as BCD."):format(v)
      error(err_msg, 2)
    end
    return high_digit * 10 + low_digit
  end
