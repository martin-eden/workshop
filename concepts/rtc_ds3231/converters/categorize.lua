--[[
  Parse array of bytes to structured table.

  Values that should contain BCD-encoded numbers are not decoded here,
  they just populated with raw bits.

  See code for result table structure.
]]

local slice_bits = request('!.number.slice_bits')
local get_bit = request('!.number.get_bit')
local uint8_to_int8 = request('!.number.uint8_to_int8')
local merge = request('!.table.merge')

local parse_hour = request('hour_parse')
local parse_temperature = request('temperature_parse')

local wave_freqs = request('^.data.wave_freqs')

return
  function(data)
    local result =
      {
        moment =
          {
            second_bcd = slice_bits(data[1], 0, 6),
            minute_bcd = slice_bits(data[2], 0, 6),
            dow_bcd = slice_bits(data[4], 0, 2),
            date_bcd = slice_bits(data[5], 0, 5),
            month_bcd = slice_bits(data[6], 0, 4),
            is_next_century = get_bit(data[6], 7),
            year_bcd = data[7],
          },
        alarm_1 =
          {
            ignore_second = get_bit(data[8], 7),
            second_bcd = slice_bits(data[8], 0, 6),
            ignore_minute = get_bit(data[9], 7),
            minute_bcd = slice_bits(data[9], 0, 6),
            ignore_hour = get_bit(data[10], 7),
            ignore_date_dow = get_bit(data[11], 7),
            is_date_not_dow = get_bit(data[11], 6),
            date_dow_bcd = slice_bits(data[11], 0, 5),
            enabled = get_bit(data[15], 0),
            occurred = get_bit(data[16], 0),
          },
        alarm_2 =
          {
            ignore_minute = get_bit(data[12], 7),
            minute_bcd = slice_bits(data[12], 0, 6),
            ignore_hour = get_bit(data[13], 7),
            ignore_date_dow = get_bit(data[14], 7),
            is_date_not_dow = get_bit(data[14], 6),
            date_dow_bcd = slice_bits(data[14], 0, 5),
            enabled = get_bit(data[15], 1),
            occurred = get_bit(data[16], 1),
          },
        output_alarms_not_wave = get_bit(data[15], 2),
        wave_freq = wave_freqs[slice_bits(data[15], 3, 4)],
        get_temperature = get_bit(data[15], 5),
        at_battery =
          {
            allow_wave_output = get_bit(data[15], 6),
            stop_clock = get_bit(data[15], 7),
            clock_was_stopped = get_bit(data[16], 7),
          },
        is_busy = get_bit(data[16], 2),
        enable_wave_32k = get_bit(data[16], 3),
        clock_speed = uint8_to_int8(data[17]),
        temperature =
          parse_temperature(
            (data[18] << 2) | slice_bits(data[19], 6, 7)
          ),
      }

    merge(result.moment, parse_hour(slice_bits(data[3], 0, 6)))
    merge(result.alarm_1, parse_hour(slice_bits(data[10], 0, 6)))
    merge(result.alarm_2, parse_hour(slice_bits(data[13], 0, 6)))

    return result
  end
