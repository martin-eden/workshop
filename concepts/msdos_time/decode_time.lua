-- Convert time in MS-DOS format (16 bits) to string with ISO 8601 time

--[[
  Author: Martin Eden
  Last mod.: 2026-05-31
]]

--[[
  Input:
    [s] raw_date -- data bytes as string

  Output:
    [s] -- ISO time
]]

-- Imports:
local get_bits = request('!.number.get_bits')

local decode_time =
  function(raw_time)
    assert_string(raw_time)
    assert(#raw_time == 2)

    local data = string.unpack('< I2', raw_time)

    local hour = get_bits(data, 11, 15)
    local minute = get_bits(data, 5, 10)
    local second = get_bits(data, 0, 4) * 2

    return string.format('%02d:%02d:%02d', hour, minute, second)
  end

-- Export:
return decode_time

--[[
  2018
  2026-05-30
]]
