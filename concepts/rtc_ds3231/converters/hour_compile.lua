--[[
  Compile 24h-format hour to DS3231 format.

  For format description see [parse_hour].

  Receives table with fields (hour: int, is_12h_format: bool).

  Returns byte.
]]

local to_ampm_hour = request('!.concepts.daytime.to_ampm_hour')
local to_bcd = request('!.number.to_bcd')
local set_bit = request('!.number.set_bit')
local splice_bits = request('!.number.splice_bits')

return
  function(rec)
    local result = 0

    if rec.store_hour_in_12h then
      local hour, is_pm = to_ampm_hour(rec.hour)
      result = set_bit(0, 6, true)
      result = set_bit(result, 5, is_pm)
      result = splice_bits(to_bcd(hour), 0, 4, result)
    else
      result = splice_bits(to_bcd(rec.hour), 0, 5, result)
    end

    return result
  end
