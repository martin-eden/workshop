--[[
  Table with paths to BCD values.

  Used in verification and conversion.

  This list is derived from [categorize] result.
]]

return
  {
    {'moment', 'second_bcd'},
    {'moment', 'minute_bcd'},
    {'moment', 'hour_bcd'},
    {'moment', 'dow_bcd'},
    {'moment', 'date_bcd'},
    {'moment', 'month_bcd'},
    {'moment', 'year_bcd'},

    {'alarm_1', 'second_bcd'},
    {'alarm_1', 'minute_bcd'},
    {'alarm_1', 'hour_bcd'},
    {'alarm_1', 'date_dow_bcd'},

    {'alarm_2', 'minute_bcd'},
    {'alarm_2', 'hour_bcd'},
    {'alarm_2', 'date_dow_bcd'},
  }
