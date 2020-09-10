--[[
  Compile 24h-format hour to DS3231 format.

  For format description see [parse_hour].

  Receives table with fields
    hour_bcd: int
    is_12h_format: bool
    [is_pm: bool]

  Returns byte.
]]

local set_bit = request('!.number.set_bit')
local splice_bits = request('!.number.splice_bits')

return
  function(rec)
    local result = 0

    if rec.is_12h_format then
      result = set_bit(0, 6, true)
      result = set_bit(result, 5, rec.is_pm)
      result = splice_bits(rec.hour_bcd, 0, 4, result)
    else
      result = splice_bits(rec.hour_bcd, 0, 5, result)
    end

    return result
  end
