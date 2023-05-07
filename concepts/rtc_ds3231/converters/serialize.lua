--[[
  Compile table with DS3231 parameters to table with sequence of
  bytes. This result table is supposed to be written to device.
]]

local set_bit = request('!.number.set_bit')
local splice_bits = request('!.number.splice_bits')
local slice_bits = request('!.number.slice_bits')
local int8_to_uint8 = request('!.number.int8_to_uint8')

local compile_hour = request('hour_compile')
local compile_temperature = request('temperature_compile')

local wave_ids = request('^.data.wave_ids')

return
  function(rec)
    local result =
      {
        [1] = splice_bits(rec.moment.second_bcd, 0, 6),
        [2] = splice_bits(rec.moment.minute_bcd, 0, 6),
        [3] = compile_hour(rec.moment),
        [4] = splice_bits(rec.moment.dow_bcd, 0, 2),
        [5] = splice_bits(rec.moment.date_bcd, 0, 5),
        [6] = splice_bits(rec.moment.month_bcd, 0, 4),
        [7] = splice_bits(rec.moment.year_bcd, 0, 7),
        [8] = splice_bits(rec.alarm_1.second_bcd, 0, 6),
        [9] = splice_bits(rec.alarm_1.minute_bcd, 0, 6),
        [10] = compile_hour(rec.alarm_1),
        [11] = splice_bits(rec.alarm_1.date_dow_bcd, 0, 5),
        [12] = splice_bits(rec.alarm_2.minute_bcd, 0, 6),
        [13] = compile_hour(rec.alarm_2),
        [14] = splice_bits(rec.alarm_2.date_dow_bcd, 0, 5),
        [15] = 0,
        [16] = 0,
        [17] = int8_to_uint8(rec.clock_speed),
      }

    result[6] = set_bit(result[6], 7, rec.moment.is_next_century)
    result[8] = set_bit(result[8], 7, rec.alarm_1.ignore_second)
    result[9] = set_bit(result[9], 7, rec.alarm_1.ignore_minute)
    result[10] = set_bit(result[10], 7, rec.alarm_1.ignore_hour)

    result[11] = set_bit(result[11], 6, rec.alarm_1.is_date_not_dow)
    result[12] = set_bit(result[12], 7, rec.alarm_1.ignore_date_dow)

    result[12] = set_bit(result[12], 7, rec.alarm_2.ignore_minute)
    result[13] = set_bit(result[13], 7, rec.alarm_2.ignore_hour)

    result[14] = set_bit(result[14], 6, rec.alarm_2.is_date_not_dow)
    result[14] = set_bit(result[14], 7, rec.alarm_2.ignore_date_dow)

    result[15] = set_bit(result[15], 0, rec.alarm_1.enabled)
    result[15] = set_bit(result[15], 1, rec.alarm_2.enabled)
    result[15] = set_bit(result[15], 2, rec.output_alarms_not_wave)
    assert(
      wave_ids[rec.wave_freq],
      ('No wave id for given freq of %s Hz'):format(rec.wave_freq)
    )
    result[15] =
      splice_bits(wave_ids[rec.wave_freq], 3, 4, result[15])
    result[15] = set_bit(result[15], 5, rec.get_temperature)
    result[15] = set_bit(result[15], 6, rec.at_battery.allow_wave_output)
    result[15] = set_bit(result[15], 7, rec.at_battery.stop_clock)
    result[16] = set_bit(result[16], 7, rec.at_battery.clock_was_stopped)

    result[16] = set_bit(result[16], 0, rec.alarm_1.occurred)
    result[16] = set_bit(result[16], 1, rec.alarm_2.occurred)
    result[16] = set_bit(result[16], 2, rec.is_busy)
    result[16] = set_bit(result[16], 3, rec.enable_wave_32k)

    local temp_raw = compile_temperature(rec.temperature)
    result[18] = slice_bits(temp_raw, 2, 9)
    result[19] = splice_bits(slice_bits(temp_raw, 0, 1), 6, 7)

    return result
  end
