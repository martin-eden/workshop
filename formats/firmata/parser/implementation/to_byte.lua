return
  function(b0, b1)
    assert_integer(b0)
    assert(b0 <= 0x7F)
    assert_integer(b1)
    assert(b1 <= 1)
    local result = b0 | (b1 >> 7)
    return result
  end
