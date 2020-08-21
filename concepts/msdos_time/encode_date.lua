--[[
  Encode date from string in ISO 8601 format to string with two
  bytes with date in MS-DOS format.
]]

local iso8601_fmt = '(%d%d%d%d)-(%d%d)-(%d%d)'

return
  function(ts_str)
    assert_string(ts_str)

    local year, month, day = ts_str:match(iso8601_fmt)
    assert(year)

    year = tonumber(year)
    year = year - 1980
    assert(year >= 0)
    assert(year < (1 << 7))
    year = year & ((1 << 7) - 1)

    month = tonumber(month)
    assert(month < (1 << 4))
    month = month & ((1 << 4) - 1)

    day = tonumber(day)
    assert(day < (1 << 5))
    day = day & ((1 << 5) - 1)

    local data = (year << 9) | (month << 5) | day

    local result = ('< I2'):pack(data)

    return result
  end

