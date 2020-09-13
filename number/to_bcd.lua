return
  function(v)
    assert_integer(v)
    assert(v >= 0, "Can't represent negative number in BCD.")
    local high_digit = v // 10
    local low_digit = v % 10
    if not ((high_digit <= 9) and (low_digit <= 9)) then
      local err_msg =
        ("Number %03d can't be represented in BCD."):format(v)
      error(err_msg, 2)
    end
    return high_digit << 4 | low_digit
  end
