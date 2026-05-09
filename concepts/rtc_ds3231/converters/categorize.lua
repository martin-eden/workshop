-- Convert bytes list with DS3231 data to structured table

--[[
  Author: Martin Eden
  Last mod.: 2026-05-09
]]

--[[
  Values that should contain BCD-encoded numbers are not decoded here,
  they just populated with raw bits.

  See code for Result table structure.
]]

-- Imports:
local get_bits = request('!.number.get_bits')
local get_bit = request('!.number.get_bit')
local sint8_from_byte = request('!.convert.sint8_from_byte')
local merge = request('!.table.merge')

local parse_hour = request('hour_parse')
local parse_temperature = request('temperature_parse')

local wave_freqs = request('^.data.wave_freqs')

local categorize =
  function(Bytes)
    local Result =
      {
        moment =
          {
            second_bcd = get_bits(Bytes[1], 0, 6),
            minute_bcd = get_bits(Bytes[2], 0, 6),
            dow_bcd = get_bits(Bytes[4], 0, 2),
            date_bcd = get_bits(Bytes[5], 0, 5),
            month_bcd = get_bits(Bytes[6], 0, 4),
            is_next_century = get_bit(Bytes[6], 7),
            year_bcd = Bytes[7],
          },
        alarm_1 =
          {
            ignore_second = get_bit(Bytes[8], 7),
            second_bcd = get_bits(Bytes[8], 0, 6),
            ignore_minute = get_bit(Bytes[9], 7),
            minute_bcd = get_bits(Bytes[9], 0, 6),
            ignore_hour = get_bit(Bytes[10], 7),
            date_dow_bcd = get_bits(Bytes[11], 0, 5),
            is_date_not_dow = get_bit(Bytes[11], 6),
            ignore_date_dow = get_bit(Bytes[11], 7),
            enabled = get_bit(Bytes[15], 0),
            occurred = get_bit(Bytes[16], 0),
          },
        alarm_2 =
          {
            ignore_minute = get_bit(Bytes[12], 7),
            minute_bcd = get_bits(Bytes[12], 0, 6),
            ignore_hour = get_bit(Bytes[13], 7),
            ignore_date_dow = get_bit(Bytes[14], 7),
            is_date_not_dow = get_bit(Bytes[14], 6),
            date_dow_bcd = get_bits(Bytes[14], 0, 5),
            enabled = get_bit(Bytes[15], 1),
            occurred = get_bit(Bytes[16], 1),
          },
        output_alarms_not_wave = get_bit(Bytes[15], 2),
        wave_freq = wave_freqs[get_bits(Bytes[15], 3, 4)],
        get_temperature = get_bit(Bytes[15], 5),
        at_battery =
          {
            allow_wave_output = get_bit(Bytes[15], 6),
            stop_clock = get_bit(Bytes[15], 7),
            clock_was_stopped = get_bit(Bytes[16], 7),
          },
        is_busy = get_bit(Bytes[16], 2),
        enable_wave_32k = get_bit(Bytes[16], 3),
        clock_speed = sint8_from_byte(Bytes[17]),
        temperature =
          parse_temperature(
            (Bytes[18] << 2) | get_bits(Bytes[19], 6, 7)
          ),
      }

    merge(Result.moment, parse_hour(get_bits(Bytes[3], 0, 6)))
    merge(Result.alarm_1, parse_hour(get_bits(Bytes[10], 0, 6)))
    merge(Result.alarm_2, parse_hour(get_bits(Bytes[13], 0, 6)))

    return Result
  end

-- Export:
return categorize

--[[
  2020 # #
  2023 #
  2026-05-03
]]
