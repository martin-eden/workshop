--[[
  Change all hour records to 24h format.

  There are three hour records: one in current time and two in alarms.
]]

local normalize_hour = request('hour_normalize')

return
  function(data)
    normalize_hour(data.moment)
    normalize_hour(data.alarm_1)
    normalize_hour(data.alarm_2)
    return data
  end
