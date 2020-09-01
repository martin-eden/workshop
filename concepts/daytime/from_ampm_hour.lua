--[[
  Calculate 24h-format hour from 12h AM/PM format.

  There is no zero hour. 00h -> 12 a.m., 12h -> 12p.m.

  This function does not check that AM/PM hour in valid range [1, 12].
  Reason is that in my use cases it may be not. And result
  verification is job of other functions.
]]

return
  function(hour, is_pm)
    assert_integer(hour)
    assert_boolean(is_pm)

    hour = hour % 12
    if is_pm then
      hour = hour + 12
    end

    return hour
  end
