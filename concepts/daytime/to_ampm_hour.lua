--[[
  Calculate 12h hour and AM/PM flag from 24h hour.

  In AM/PM there are no zero hour. 00h -> 12 a.m., 12h -> 12p.m.

  This function does not check that given hour number in valid
  range [0, 23]. It's job for other functions.
]]

return
  function(hour)
    assert_integer(hour)

    local is_pm = (hour >= 12)
    if is_pm then
      hour = hour - 12
    end
    if (hour == 0) then
      hour = 12
    end

    return hour, is_pm
  end
