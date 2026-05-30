-- Encode string with ISO time to string with bytes in MS-DOS format

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

-- Imports:
local set_bits = request('!.number.set_bits')

local iso8601_time_fmt = '(%d%d):(%d%d):(%d%d)'

local encode_time =
  function(iso_time)
    assert_string(iso_time)

    local hour, minute, second = string.match(iso_time, iso8601_time_fmt)
    assert(hour)

    hour = tonumber(hour)
    assert(hour < (1 << 5))

    minute = tonumber(minute)
    assert(minute < (1 << 6))

    second = tonumber(second)
    second = second // 2
    assert(second < (1 << 5))

    local data = set_bits(hour, 11, 15)
    data = set_bits(minute, 5, 10, data)
    data = set_bits(second, 0, 4, data)

    return string.pack('< I2', data)
  end

-- Export:
return encode_time

--[[
  2018
  2026-05-30
]]
