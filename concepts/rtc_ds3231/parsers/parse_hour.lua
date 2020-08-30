--[[
  Parse byte with hour value.

  There are two formats to store hour: 24h and 12h with am/pm flag.
  For 24h format valid hours are 0..23, for 12h - 1..12.

  24h format:

    7 6 5 4 3 2 1 0
    0 0 ~~~~~~~~~~~ BCD value 0..23

  12h format:

    7 6 5 4 3 2 1 0
    0 1 | ~~~~~~~~~ BCD value 1..12
        ~ 0 - AM, 1 - PM

  Returns table with following fields:

    is_12h_format
    hour_bcd
    is_pm (bool or nil)
]]

local get_bit = request('!.number.get_bit')
local slice_bits = request('!.number.slice_bits')

return
  function(v)
    local is_12h_format = get_bit(v, 6)
    local hour_bcd, is_pm

    if is_12h_format then
      hour_bcd = slice_bits(v, 0, 4)
      is_pm = get_bit(v, 5)
    else
      hour_bcd = slice_bits(v, 0, 5)
    end

    return
      {
        is_12h_format = is_12h_format,
        hour_bcd = hour_bcd,
        is_pm = is_pm,
      }
  end
