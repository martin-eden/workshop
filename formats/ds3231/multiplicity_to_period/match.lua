--[[
  Return string with recurrence period for given record with alarm
  time.

  Recurrence period is stored quite obscurely: as set
  of four boolean fields:

    ignore_date_dow X X X X - every month or day of week at custom time
    ignore_hour     X X X - every day at custom hour, minute, second
    ignore_minute   X X - every hour at custom minute, second
    ignore_second   X - every minute at custom second
                    every second

  To distinguish whether stored number is date of month or day of week
  <is_date_not_dow> used.
]]

local ignore_fields =
  {'ignore_date_dow', 'ignore_hour', 'ignore_minute', 'ignore_second'}

local intervals =
  {
    [false] = {'week', 'day', 'hour', 'minute', 'second'},
    [true] = {'month', 'day', 'hour', 'minute', 'second'},
  }

return
  function(alarm_rec)
    local false_pos = #ignore_fields + 1
    for i = 1, #ignore_fields do
      if not alarm_rec[ignore_fields[i]] then
        false_pos = i
        break
      end
    end
    -- Remained fields should be false. Return nil if it is not so.
    for i = false_pos + 1, #ignore_fields do
      if alarm_rec[ignore_fields[i]] then
        return
      end
    end
    return intervals[alarm_rec.is_date_not_dow][false_pos]
  end
