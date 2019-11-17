local to_bcd = request('!.number.to_bcd')
local set_bit = request('!.number.set_bit')
local splice_bits = request('!.number.splice_bits')

local compile_hour =
  function(rec)
    local hour = rec.hour
    local is_12h_format = rec.is_12h_format
    local result
    if is_12h_format then
      local is_pm
      if (hour <= 11) then
        is_pm = false
        if (hour == 0) then
          hour = 12
        end
      else
        is_pm = true
        if (hour ~= 12) then
          hour = hour - 12
        end
      end
      result = (1 << 6) | to_bcd(hour)
      if is_pm then
        result = result | (1 << 5)
      end
    else
      result = to_bcd(hour)
    end
    return result
  end

local compile_temperature =
  function(temp)
    assert((temp >= -128) and (temp <= 127.75))

    temp = math.modf(temp * 4)
    temp = math.tointeger(temp)
    -- <temp> now is signed integer holding 10-bit value
    local int_part = (temp >> 2) & 0xFF
    local frac_part = (temp & 0x3)

    return int_part, frac_part
  end

local int8_to_uint8 =
  function(v)
    return ('B'):unpack(('b'):pack(v))
  end

local wave_ids =
  {
    [1] = 0,
    [1024] = 1,
    [4096] = 2,
    [8192] = 3,
  }

return
  function(rec)
    local result =
      {
        [0] = splice_bits(0, 0, 6, to_bcd(rec.moment.second)),
        [1] = splice_bits(0, 0, 6, to_bcd(rec.moment.minute)),
        [2] = compile_hour(rec.moment),
        [3] = splice_bits(0, 0, 2, to_bcd(rec.moment.dow)),
        [4] = splice_bits(0, 0, 5, to_bcd(rec.moment.date)),
        [5] = splice_bits(0, 0, 4, to_bcd(rec.moment.month)),
        [6] = to_bcd(rec.moment.year % 100),
        [7] = splice_bits(0, 0, 6, to_bcd(rec.alarm[1].second)),
        [8] = splice_bits(0, 0, 6, to_bcd(rec.alarm[1].minute)),
        [9] = compile_hour(rec.alarm[1]),
        [10] = splice_bits(0, 0, 5, to_bcd(rec.alarm[1].date_day)),
        [11] = splice_bits(0, 0, 6, to_bcd(rec.alarm[2].minute)),
        [12] = compile_hour(rec.alarm[2]),
        [13] = splice_bits(0, 0, 5, to_bcd(rec.alarm[2].date_day)),
        [14] = 0,
        [15] = 0,
        [16] = int8_to_uint8(rec.aging),
      }

    result[5] = set_bit(result[5], 7, rec.moment.is_next_century)
    result[7] = set_bit(result[7], 7, rec.alarm[1].ignore_second)
    result[8] = set_bit(result[8], 7, rec.alarm[1].ignore_minute)
    result[9] = set_bit(result[9], 7, rec.alarm[1].ignore_hour)

    result[10] = set_bit(result[10], 6, rec.alarm[1].is_date_not_day)
    result[10] = set_bit(result[10], 7, rec.alarm[1].ignore_date_day)

    result[11] = set_bit(result[11], 7, rec.alarm[2].ignore_minute)
    result[12] = set_bit(result[12], 7, rec.alarm[2].ignore_hour)

    result[13] = set_bit(result[13], 6, rec.alarm[2].is_date_not_day)
    result[13] = set_bit(result[13], 7, rec.alarm[2].ignore_date_day)

    result[14] = set_bit(result[14], 0, rec.alarm[1].enabled)
    result[14] = set_bit(result[14], 1, rec.alarm[2].enabled)
    result[14] = set_bit(result[14], 2, rec.output_alarms_not_custom_wave)
    result[14] =
      splice_bits(result[14], 3, 4, wave_ids[rec.custom_wave_freq])
    result[14] = set_bit(result[14], 5, rec.converting_temperature)
    result[14] = set_bit(result[14], 6, rec.at_battery.custom_wave_output_allowed)
    result[14] = set_bit(result[14], 7, rec.at_battery.clock_disabled)

    result[15] = set_bit(result[15], 0, rec.alarm[1].triggered)
    result[15] = set_bit(result[15], 1, rec.alarm[2].triggered)
    result[15] = set_bit(result[15], 2, rec.is_busy)
    result[15] = set_bit(result[15], 3, rec.fixed_wave_32k_enabled)
    result[15] = set_bit(result[15], 7, rec.clock_was_stopped)

    result[17], result[18] = compile_temperature(rec.temperature)

    return result
  end
