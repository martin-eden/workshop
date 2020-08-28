return
  function(second)
    assert_integer(second)
    local result, err_msg
    result = (second >= 0) and (second <= 59)
    if not result then
      err_msg =
        ('Given second number %d is not in range [0, 59].'):format(second)
    end
    return result, err_msg
  end
