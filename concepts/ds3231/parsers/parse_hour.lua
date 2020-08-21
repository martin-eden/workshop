--[[
  Parse byte with hour value.

  Format is

    7 6 5 4 3 2 1 0
    ~ ~ ------------- 0 - 24h format
    0   ~~~~~~~~~~~ ---- BCD value 00..23
      ~ ------------- 1 - am/pm 12h format
        ~ -------------- 0 - AM, 1 - PM
          ~~~~~~~~~ ---- BCD value 01..12

  Return
    {
      is_12h_format: bool
      hour_bcd: int
      is_pm: bool or nil
    }
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
