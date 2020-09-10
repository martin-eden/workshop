--[[
  Table with paths to BCD values and their new names after BCD
  conversion.

  Used both in parsing and compiling.

  This list is derived from [categorize] result.
]]

return
  {
    {bcd = {'moment', 'second_bcd'}, int = {'moment', 'second'}},
    {bcd = {'moment', 'minute_bcd'}, int = {'moment', 'minute'}},
    {bcd = {'moment', 'hour_bcd'}, int = {'moment', 'hour'}},
    {bcd = {'moment', 'dow_bcd'}, int = {'moment', 'dow'}},
    {bcd = {'moment', 'date_bcd'}, int = {'moment', 'date'}},
    {bcd = {'moment', 'month_bcd'}, int = {'moment', 'month'}},
    {bcd = {'moment', 'year_bcd'}, int = {'moment', 'year'}},

    {bcd = {'alarm_1', 'second_bcd'}, int = {'alarm_1', 'second'}},
    {bcd = {'alarm_1', 'minute_bcd'}, int = {'alarm_1', 'minute'}},
    {bcd = {'alarm_1', 'hour_bcd'}, int = {'alarm_1', 'hour'}},
    {bcd = {'alarm_1', 'date_dow_bcd'}, int = {'alarm_1', 'date_dow'}},

    {bcd = {'alarm_2', 'minute_bcd'}, int = {'alarm_2', 'minute'}},
    {bcd = {'alarm_2', 'hour_bcd'}, int = {'alarm_2', 'hour'}},
    {bcd = {'alarm_2', 'date_dow_bcd'}, int = {'alarm_2', 'date_dow'}},
  }
