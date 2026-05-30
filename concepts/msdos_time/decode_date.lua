-- Convert date in MS-DOS format (16 bits) to string with ISO 8601 date

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

--[[
  Input:
    [s] raw_date -- data bytes as string
  Output:
    [s] -- ISO date
]]

-- Imports:
local get_bits = request('!.number.get_bits')

local decode_date =
  function(raw_date)
    assert_string(raw_date)
    assert(#raw_date == 2)

    local data = string.unpack('< I2', raw_date)

    local year = get_bits(data, 9, 15) + 1980
    local month = get_bits(data, 5, 8)
    local day = get_bits(data, 0, 4)

    return string.format('%04d-%02d-%02d', year, month, day)
  end

-- Export:
return decode_date

--[[
  2018
  2026-05-30
]]
