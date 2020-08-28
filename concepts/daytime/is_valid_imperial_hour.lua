return
  function(hour)
    assert_integer(hour)
    local result, err_msg
    result = (hour >= 1) and (hour <= 12)
    if not result then
      err_msg =
        ('Given hour number %d is not in range [1, 12].'):format(hour)
    end
    return result, err_msg
  end
