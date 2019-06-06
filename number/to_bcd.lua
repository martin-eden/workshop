return
  function(v)
    assert_integer(v)
    assert((v >= 0) and (v <= 99))
    local high_nibble = v // 10
    local low_nibble = v % 10
    return high_nibble << 4 | low_nibble
  end
