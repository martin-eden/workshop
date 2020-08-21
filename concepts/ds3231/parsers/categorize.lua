--[[
  Parse without parsing BCD values.

  Parse table with sequence of bytes (assumed to be read from device
  memory) to structured table with named keys.

  See code for result table structure.
]]

local slice_bits = request('!.number.slice_bits')
local get_bit = request('!.number.get_bit')
local uint8_to_int8 = request('!.number.uint8_to_int8')
local merge = request('!.table.merge')

local parse_hour = request('parse_hour')
local parse_temperature = request('parse_temperature')

local wave_freqs = request('^.wave_freqs')

return
  function(data)
    local result =
      {
        moment =
          {
            second_bcd = slice_bits(data[0], 0, 6),
            minute_bcd = slice_bits(data[1], 0, 6),
            dow_bcd = slice_bits(data[3], 0, 2),
            date_bcd = slice_bits(data[4], 0, 5),
            month_bcd = slice_bits(data[5], 0, 4),
            is_next_century = get_bit(data[5], 7),
            year_bcd = data[6],
          },
        alarm =
          {
            [1] =
              {
                ignore_second = get_bit(data[7], 7),
                second_bcd = slice_bits(data[7], 0, 6),
                ignore_minute = get_bit(data[8], 7),
                minute_bcd = slice_bits(data[8], 0, 6),
                ignore_hour = get_bit(data[9], 7),
                ignore_date_dow = get_bit(data[10], 7),
                is_date_not_dow = get_bit(data[10], 6),
                date_dow_bcd = slice_bits(data[10], 0, 5),
                enabled = get_bit(data[14], 0),
                occurred = get_bit(data[15], 0),
              },
            [2] =
              {
                ignore_minute = get_bit(data[11], 7),
                minute_bcd = slice_bits(data[11], 0, 6),
                ignore_hour = get_bit(data[12], 7),
                ignore_date_dow = get_bit(data[13], 7),
                is_date_not_dow = get_bit(data[13], 0, 6),
                date_dow_bcd = slice_bits(data[13], 0, 5),
                enabled = get_bit(data[14], 1),
                occurred = get_bit(data[15], 1),
              },
          },
        output_alarms_not_custom_wave = get_bit(data[14], 2),
        custom_wave_freq = wave_freqs[slice_bits(data[14], 3, 4)],
        converting_temperature = get_bit(data[14], 5),
        at_battery =
          {
            custom_wave_output_allowed = get_bit(data[14], 6),
            clock_disabled = get_bit(data[14], 7),
          },
        is_busy = get_bit(data[15], 2),
        fixed_wave_32k_enabled = get_bit(data[15], 3),
        clock_was_stopped = get_bit(data[15], 7),
        clock_speed = uint8_to_int8(data[16]),
        temperature =
          parse_temperature(data[17], slice_bits(data[18], 6, 7)),
      }

    local hour = parse_hour(slice_bits(data[2], 0, 6))
    merge(result.moment, hour)

    local alarm_1_hour = parse_hour(slice_bits(data[9], 0, 6))
    merge(result.alarm[1], alarm_1_hour)

    local alarm_2_hour = parse_hour(slice_bits(data[12], 0, 6))
    merge(result.alarm[2], alarm_2_hour)

    return result
  end
