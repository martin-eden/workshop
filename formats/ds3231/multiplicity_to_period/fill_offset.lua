local offset_fields = {'hour', 'minute', 'second'}

local set_fields =
  function(alarm_rec, result, start_offs)
    for i = start_offs, #offset_fields do
      result[offset_fields[i]] = alarm_rec[offset_fields[i]]
    end
  end

return
  function(period, alarm_rec)
    assert_string(period)

    local result = {}

    if (period == 'month') then
      result.date = alarm_rec.date_dow
      set_fields(alarm_rec, result, 1)
    elseif (period == 'week') then
      result.dow = alarm_rec.date_dow
      set_fields(alarm_rec, result, 1)
    elseif (period == 'day') then
      set_fields(alarm_rec, result, 1)
    elseif (period == 'hour') then
      set_fields(alarm_rec, result, 2)
    elseif (period == 'minute') then
      set_fields(alarm_rec, result, 3)
    elseif (period == 'second') then
      ;
    else
      error(('Unknown period value "%s".'):format(period))
    end

    return result
  end
