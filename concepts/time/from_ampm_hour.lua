return
  function(hour, is_pm)
    assert_integer(hour)
    assert((hour >= 1) and (hour <= 12))
    assert_boolean(is_pm)

    -- There is no zero hour. 00h -> 12 a.m., 12h -> 12p.m.
    hour = hour % 12
    if is_pm then
      hour = hour + 12
    end

    return hour
  end
