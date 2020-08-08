--[[
  Return table with paths to BCD values.

  Needed for further verification and conversion.

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

    {'alarm', 1, 'second_bcd'},
    {'alarm', 1, 'minute_bcd'},
    {'alarm', 1, 'hour_bcd'},
    {'alarm', 1, 'date_dow_bcd'},

    {'alarm', 2, 'minute_bcd'},
    {'alarm', 2, 'hour_bcd'},
    {'alarm', 2, 'date_dow_bcd'},
  }
