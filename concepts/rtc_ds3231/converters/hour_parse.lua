--[[
  Parse byte with hour value.

  There are two formats to store hour: 24h and 12h with AM/PM flag.

  24h format:

    6 5 4 3 2 1 0
    0 ~~~~~~~~~~~ BCD value (0..23)

  12h format:

    6 5 4 3 2 1 0
    1 | ~~~~~~~~~ BCD value (1..12)
      ~ 0 - AM, 1 - PM

  Returns table with following fields:

    is_12h_format
    hour_bcd
    is_pm (bool or nil)
]]

local get_bit = request('!.number.get_bit')
local slice_bits = request('!.number.slice_bits')

return
  function(hour_byte)
    local hour_bcd, is_12h_format, is_pm

    is_12h_format = get_bit(hour_byte, 6)

    if is_12h_format then
      hour_bcd = slice_bits(hour_byte, 0, 4)
      is_pm = get_bit(hour_byte, 5)
    else
      hour_bcd = slice_bits(hour_byte, 0, 5)
    end

    return
      {
        is_12h_format = is_12h_format,
        hour_bcd = hour_bcd,
        is_pm = is_pm,
      }
  end
