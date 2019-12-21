--[[
  Parse table with sequence of bytes (assumed to be read from
  device memory) to structured table with named keys.

  See code for result table structure.
]]

local slice_bits = request('!.number.slice_bits')
local get_bit = request('!.number.get_bit')
local from_bcd = request('!.number.from_bcd')
local uint8_to_int8 = request('!.number.uint8_to_int8')
local merge = request('!.table.merge')

local parse_hour = request('parse.hour')
local parse_temperature = request('parse.temperature')

local wave_freqs = request('wave_freqs')

local base_century = 20

return
  function(dump)
    assert_table(dump)

    local result =
      {
        moment =
          {
            second = from_bcd(slice_bits(dump[0], 0, 6)),
            minute = from_bcd(slice_bits(dump[1], 0, 6)),
            dow = from_bcd(slice_bits(dump[3], 0, 2)),
            date = from_bcd(slice_bits(dump[4], 0, 5)),
            month = from_bcd(slice_bits(dump[5], 0, 4)),
            is_next_century = get_bit(dump[5], 7),
            year = base_century * 100 + from_bcd(dump[6]),
          },
        alarm =
          {
            [1] =
              {
                ignore_second = get_bit(dump[7], 7),
                second = from_bcd(slice_bits(dump[7], 0, 6)),
                ignore_minute = get_bit(dump[8], 7),
                minute = from_bcd(slice_bits(dump[8], 0, 6)),
                ignore_hour = get_bit(dump[9], 7),
                ignore_date_dow = get_bit(dump[10], 7),
                is_date_not_dow = get_bit(dump[10], 6),
                date_dow = from_bcd(slice_bits(dump[10], 0, 5)),
                enabled = get_bit(dump[14], 0),
                occurred = get_bit(dump[15], 0),
              },
            [2] =
              {
                ignore_minute = get_bit(dump[11], 7),
                minute = from_bcd(slice_bits(dump[11], 0, 6)),
                ignore_hour = get_bit(dump[12], 7),
                ignore_date_dow = get_bit(dump[13], 7),
                is_date_not_dow = get_bit(dump[13], 0, 6),
                date_dow = from_bcd(slice_bits(dump[13], 0, 5)),
                enabled = get_bit(dump[14], 1),
                occurred = get_bit(dump[15], 1),
              },
          },
        output_alarms_not_custom_wave = get_bit(dump[14], 2),
        custom_wave_freq = wave_freqs[slice_bits(dump[14], 3, 4)],
        converting_temperature = get_bit(dump[14], 5),
        at_battery =
          {
            custom_wave_output_allowed = get_bit(dump[14], 6),
            clock_disabled = get_bit(dump[14], 7),
          },
        is_busy = get_bit(dump[15], 2),
        fixed_wave_32k_enabled = get_bit(dump[15], 3),
        clock_was_stopped = get_bit(dump[15], 7),
        clock_speed = uint8_to_int8(dump[16]),
        temperature = parse_temperature(dump[17], dump[18]),
      }

    local hour = parse_hour(slice_bits(dump[2], 0, 6))
    merge(result.moment, hour)

    local alarm_1_hour = parse_hour(slice_bits(dump[9], 0, 6))
    merge(result.alarm[1], alarm_1_hour)

    local alarm_2_hour = parse_hour(slice_bits(dump[12], 0, 6))
    merge(result.alarm[2], alarm_2_hour)

    if result.is_next_century then
      result.year = result.year + 100
    end

    return result
  end
