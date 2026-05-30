-- Encode string with ISO date to string with bytes in MS-DOS format

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

-- Imports:
local set_bits = request('!.number.set_bits')

local iso8601_date_fmt = '(%d%d%d%d)-(%d%d)-(%d%d)'

local encode_date =
  function(iso_date)
    assert_string(iso_date)

    local year, month, day = string.match(iso_date, iso8601_date_fmt)
    assert(year)

    year = tonumber(year)
    year = year - 1980
    assert(year >= 0)
    assert(year < (1 << 7))

    month = tonumber(month)
    assert(month < (1 << 4))

    day = tonumber(day)
    assert(day < (1 << 5))

    local data = set_bits(year, 9, 15)
    data = set_bits(month, 5, 8, data)
    data = set_bits(day, 0, 4, data)

    return string.pack('< I2', data)
  end

-- Export:
return encode_date

--[[
  2018
  2026-05-30
]]
