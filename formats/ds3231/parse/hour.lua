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
      hour: int
      is_12h_format: bool
    }
]]

local get_bit = request('!.number.get_bit')
local slice_bits = request('!.number.slice_bits')
local from_bcd = request('!.number.from_bcd')
local from_ampm_hour = request('!.formats.time.from_ampm_hour')

return
  function(v)
    local is_12h_format = get_bit(v, 6)
    local hour

    if is_12h_format then
      hour = from_bcd(slice_bits(v, 0, 4))
      local is_pm = get_bit(v, 5)
      hour = from_ampm_hour(hour, is_pm)
    else
      hour = from_bcd(v)
    end

    return
      {
        hour = hour,
        is_12h_format = is_12h_format,
      }
  end
