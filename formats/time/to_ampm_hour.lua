return
  function(hour)
    assert_integer(hour)
    assert((hour >= 0) and (hour <= 23))

    -- There is no zero hour. 00h -> 12 a.m., 12h -> 12p.m.
    local is_pm = (hour >= 12)
    if is_pm then
      hour = hour - 12
    end
    if (hour == 0) then
      hour = 12
    end

    return hour, is_pm
  end
