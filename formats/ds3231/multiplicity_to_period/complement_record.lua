--[[
  There are two alarm records in DS3231 RTC module. One can
  trigger up to every second, other up to every minute. That
  minute record lacks fields <ignore_second> and <second>.

  This function adds these fields to parsed record with dummy values.
  This is needed to avoid creating breed of parsing code.
  But generally it is bad thing to modify given parameters.
]]

return
  function(alarm_rec)
    assert_table(alarm_rec)
    if is_nil(alarm_rec.ignore_second) then
      alarm_rec.ignore_second = false
      alarm_rec.second = 0
    end
  end
