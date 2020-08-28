return
  function(minute)
    assert_integer(minute)
    local result, err_msg
    result = (minute >= 0) and (minute <= 59)
    if not result then
      err_msg =
        ('Given minute number %d is not in range [0, 59].'):format(minute)
    end
    return result, err_msg
  end
