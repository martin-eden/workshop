local FromIsoDate = request('FromIsoDate')
local FromIsoTime = request('FromIsoTime')

local DateTimeFmt = '^([^ ]-) ([^ ]+)$'

return
  function(DateTimeStr)
    assert_string(DateTimeStr)
    local DateStr, TimeStr = DateTimeStr:match(DateTimeFmt)
    if not DateStr then
      error(
        ('Unable to select ISO 9601 date-time parts from string %q.'):
        format(DateTimeStr)
      )
    end
    local Year, Month, Day = FromIsoDate(DateStr)
    local Hour, Minute, Second = FromIsoTime(TimeStr)
    return Year, Month, Day, Hour, Minute, Second
  end

