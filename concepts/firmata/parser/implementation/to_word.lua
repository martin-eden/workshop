-- Convert two 7-bit integers to 14-bit word

return
  function(self, b0, b1)
    assert_integer(b0)
    assert(b0 <= 0x7F)
    assert_integer(b1)
    assert(b1 <= 0x7F)
    local result = b0 | (b1 << 7)
    return result
  end
