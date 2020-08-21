--[[
  Encode time from string in ISO 8601 format to string with two
  bytes with time in MS-DOS format.
]]

local iso8601_fmt = '(%d%d):(%d%d):(%d%d)'

return
  function(dt_str)
    assert_string(dt_str)

    local hour, minute, second = (dt_str):match(iso8601_fmt)
    assert(hour)

    hour = tonumber(hour)
    assert(hour < (1 << 5))
    hour = hour & ((1 << 5) - 1)

    minute = tonumber(minute)
    assert(minute < (1 << 6))
    minute = minute & ((1 << 6) - 1)

    second = tonumber(second)
    second = second // 2
    assert(second < (1 << 5))
    second = second & ((1 << 5) - 1)

    local data = (hour << 11) | (minute << 5) | second

    local result = ('< I2'):pack(data)

    return result
  end
