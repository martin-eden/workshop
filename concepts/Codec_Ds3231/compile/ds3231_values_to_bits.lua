-- Serialize our tree values to bits strings

--[[
  Author: Martin Eden
  Last mod.: 2026-05-10
]]

-- Imports:
local bool_to_bit = request('!.convert.bool_to_bit')
local byte_to_bits = request('!.convert.byte_to_bits')
local sint8_to_byte = request('!.convert.sint8_to_byte')

local tree_values_to_bits =
  function(DataTree)
    return
      {
        Status =
          {
            ['32kihz_pin_enabled'] =
              bool_to_bit(DataTree.Status['32kihz_pin_enabled']),
            alarm_1_enabled =
              bool_to_bit(DataTree.Status.alarm_1_enabled),
            alarm_1_occurred =
              bool_to_bit(DataTree.Status.alarm_1_occurred),
            alarm_2_occurred =
              bool_to_bit(DataTree.Status.alarm_2_occurred),
            is_busy =
              bool_to_bit(DataTree.Status.is_busy),
            atbattery_clock_disabled =
              bool_to_bit(DataTree.Status.atbattery_clock_disabled),
            getting_temperature =
              bool_to_bit(DataTree.Status.getting_temperature),
            atbattery_enable_wave =
              bool_to_bit(DataTree.Status.atbattery_enable_wave),
            output_is_from_alarms =
              bool_to_bit(DataTree.Status.output_is_from_alarms),
            time_is_spoiled =
              bool_to_bit(DataTree.Status.time_is_spoiled),
            speed_trim =
              byte_to_bits(sint8_to_byte(DataTree.Status.speed_trim)),
            wave_freq_num =
              byte_to_bits(DataTree.Status.wave_freq_num),

            Temperature =
              {
                is_neg =
                  bool_to_bit(DataTree.Status.Temperature.is_neg),
                int =
                  byte_to_bits(DataTree.Status.Temperature.int),
                frac =
                  byte_to_bits(DataTree.Status.Temperature.frac),
              },
          },

        Moment =
          {
            is_next_century =
              bool_to_bit(DataTree.Moment.is_next_century),
            year_bcd =
              byte_to_bits(DataTree.Moment.year_bcd),
            month_bcd =
              byte_to_bits(DataTree.Moment.month_bcd),
            date_bcd =
              byte_to_bits(DataTree.Moment.date_bcd),
            day_bcd =
              byte_to_bits(DataTree.Moment.day_bcd),
            hour_is_12h_format =
              bool_to_bit(DataTree.Moment.hour_is_12h_format),
            hour_data =
              byte_to_bits(DataTree.Moment.hour_data),
            minute_bcd =
              byte_to_bits(DataTree.Moment.minute_bcd),
            second_bcd =
              byte_to_bits(DataTree.Moment.second_bcd),
          },

        Alarm_1 =
          {
            dateday_bcd =
              byte_to_bits(DataTree.Alarm_1.dateday_bcd),
            dateday_is_day =
              bool_to_bit(DataTree.Alarm_1.dateday_is_day),
            ignore_dateday =
              bool_to_bit(DataTree.Alarm_1.ignore_dateday),

            hour_is_12h_format =
              bool_to_bit(DataTree.Alarm_1.hour_is_12h_format),
            hour_data =
              byte_to_bits(DataTree.Alarm_1.hour_data),
            ignore_hour =
              bool_to_bit(DataTree.Alarm_1.ignore_hour),

            minute_bcd =
              byte_to_bits(DataTree.Alarm_1.minute_bcd),
            ignore_minute =
              bool_to_bit(DataTree.Alarm_1.ignore_minute),

            second_bcd =
              byte_to_bits(DataTree.Alarm_1.second_bcd),
            ignore_second =
              bool_to_bit(DataTree.Alarm_1.ignore_second),
          },

        Alarm_2 =
          {
            dateday_bcd =
              byte_to_bits(DataTree.Alarm_2.dateday_bcd),
            dateday_is_day =
              bool_to_bit(DataTree.Alarm_2.dateday_is_day),
            ignore_dateday =
              bool_to_bit(DataTree.Alarm_2.ignore_dateday),

            hour_is_12h_format =
              bool_to_bit(DataTree.Alarm_2.hour_is_12h_format),
            hour_data =
              byte_to_bits(DataTree.Alarm_2.hour_data),
            ignore_hour =
              bool_to_bit(DataTree.Alarm_2.ignore_hour),

            minute_bcd =
              byte_to_bits(DataTree.Alarm_2.minute_bcd),
            ignore_minute =
              bool_to_bit(DataTree.Alarm_2.ignore_minute),
          },
      }
  end

-- Export:
return tree_values_to_bits

--[[
  2026-05-07
  2026-05-10
]]
