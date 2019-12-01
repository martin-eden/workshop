local to_bcd = request('!.number.to_bcd')
local set_bit = request('!.number.set_bit')
local splice_bits = request('!.number.splice_bits')

local compile_hour = request('compile.hour')
local compile_temperature = request('compile.temperature')

local int8_to_uint8 = request('!.number.int8_to_uint8')

local wave_ids = request('wave_ids')

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
        [10] = splice_bits(0, 0, 5, to_bcd(rec.alarm[1].date_dow)),
        [11] = splice_bits(0, 0, 6, to_bcd(rec.alarm[2].minute)),
        [12] = compile_hour(rec.alarm[2]),
        [13] = splice_bits(0, 0, 5, to_bcd(rec.alarm[2].date_dow)),
        [14] = 0,
        [15] = 0,
        [16] = int8_to_uint8(rec.clock_speed),
      }

    result[5] = set_bit(result[5], 7, rec.moment.is_next_century)
    result[7] = set_bit(result[7], 7, rec.alarm[1].ignore_second)
    result[8] = set_bit(result[8], 7, rec.alarm[1].ignore_minute)
    result[9] = set_bit(result[9], 7, rec.alarm[1].ignore_hour)

    result[10] = set_bit(result[10], 6, rec.alarm[1].is_date_not_dow)
    result[10] = set_bit(result[10], 7, rec.alarm[1].ignore_date_dow)

    result[11] = set_bit(result[11], 7, rec.alarm[2].ignore_minute)
    result[12] = set_bit(result[12], 7, rec.alarm[2].ignore_hour)

    result[13] = set_bit(result[13], 6, rec.alarm[2].is_date_not_dow)
    result[13] = set_bit(result[13], 7, rec.alarm[2].ignore_date_dow)

    result[14] = set_bit(result[14], 0, rec.alarm[1].enabled)
    result[14] = set_bit(result[14], 1, rec.alarm[2].enabled)
    result[14] = set_bit(result[14], 2, rec.output_alarms_not_custom_wave)
    assert(
      wave_ids[rec.custom_wave_freq],
      ('No wave id for given freq of %s Hz'):format(rec.custom_wave_freq)
    )
    result[14] =
      splice_bits(result[14], 3, 4, wave_ids[rec.custom_wave_freq])
    result[14] = set_bit(result[14], 5, rec.converting_temperature)
    result[14] = set_bit(result[14], 6, rec.at_battery.custom_wave_output_allowed)
    result[14] = set_bit(result[14], 7, rec.at_battery.clock_disabled)

    result[15] = set_bit(result[15], 0, rec.alarm[1].occurred)
    result[15] = set_bit(result[15], 1, rec.alarm[2].occurred)
    result[15] = set_bit(result[15], 2, rec.is_busy)
    result[15] = set_bit(result[15], 3, rec.fixed_wave_32k_enabled)
    result[15] = set_bit(result[15], 7, rec.clock_was_stopped)

    result[17], result[18] = compile_temperature(rec.temperature)

    return result
  end
