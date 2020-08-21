--[[
  Compile hour to DS3231 format.

  For format description see [^.parse.hour].

  Receives {hour: int, is_12h_format: bool}.

  Returns byte.
]]

local set_bit = request('!.number.set_bit')
local to_bcd = request('!.number.to_bcd')
local splice_bits = request('!.number.splice_bits')
local to_ampm_hour = request('!.formats.time.to_ampm_hour')

return
  function(rec)
    local result

    if rec.is_12h_format then
      local hour, is_pm = to_ampm_hour(rec.hour)
      result = set_bit(0, 6, true)
      result = set_bit(result, 5, is_pm)
      result = splice_bits(result, 0, 4, to_bcd(hour))
    else
      result = to_bcd(rec.hour)
    end

    return result
  end
