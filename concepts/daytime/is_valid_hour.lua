return
  function(hour)
    assert_integer(hour)
    local result, err_msg
    result = (hour >= 0) and (hour <= 23)
    if not result then
      err_msg =
        ('Given hour number %d is not in range [0, 23].'):format(hour)
    end
    return result, err_msg
  end
