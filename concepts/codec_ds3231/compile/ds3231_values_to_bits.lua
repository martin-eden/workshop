-- Serialize our tree values to bits strings

--[[
  Author: Martin Eden
  Last mod.: 2026-11-26
]]

local bool_to_bit = request('!.convert.bool_to_bit')
local byte_to_bits = request('!.convert.byte_to_bits')
local sint8_to_byte = request('!.convert.sint8_to_byte')

return
  function(data)
    return
      {
        status =
          {
            ['32kihz_pin_enabled'] =
              bool_to_bit(data.Status['32kihz_pin_enabled']),
            alarm_1_enabled =
              bool_to_bit(data.Status.alarm_1_enabled),
            alarm_1_occurred =
              bool_to_bit(data.Status.alarm_1_occurred),
            alarm_2_occurred =
              bool_to_bit(data.Status.alarm_2_occurred),
            is_busy =
              bool_to_bit(data.Status.is_busy),
            atbattery_clock_disabled =
              bool_to_bit(data.Status.atbattery_clock_disabled),
            getting_temperature =
              bool_to_bit(data.Status.getting_temperature),
            atbattery_enable_wave =
              bool_to_bit(data.Status.atbattery_enable_wave),
            output_is_from_alarms =
              bool_to_bit(data.Status.output_is_from_alarms),
            time_is_spoiled =
              bool_to_bit(data.Status.time_is_spoiled),
            speed_trim =
              byte_to_bits(sint8_to_byte(data.Status.speed_trim)),
            wave_freq_num =
              byte_to_bits(data.Status.wave_freq_num),

            temperature =
              {
                is_neg =
                  bool_to_bit(data.Status.Temperature.is_neg),
                int =
                  byte_to_bits(data.Status.Temperature.int),
                frac =
                  byte_to_bits(data.Status.Temperature.frac),
              },
          },

        moment =
          {
            is_next_century =
              bool_to_bit(data.Moment.is_next_century),
            year_bcd =
              byte_to_bits(data.Moment.year_bcd),
            month_bcd =
              byte_to_bits(data.Moment.month_bcd),
            date_bcd =
              byte_to_bits(data.Moment.date_bcd),
            day_bcd =
              byte_to_bits(data.Moment.day_bcd),
            hour_is_12h_format =
              bool_to_bit(data.Moment.hour_is_12h_format),
            hour_data =
              byte_to_bits(data.Moment.hour_data),
            minute_bcd =
              byte_to_bits(data.Moment.minute_bcd),
            second_bcd =
              byte_to_bits(data.Moment.second_bcd),
          },

        alarm_1 =
          {
            dateday_bcd =
              byte_to_bits(data.Alarm_1.dateday_bcd),
            dateday_is_day =
              bool_to_bit(data.Alarm_1.dateday_is_day),
            ignore_dateday =
              bool_to_bit(data.Alarm_1.ignore_dateday),

            hour_is_12h_format =
              bool_to_bit(data.Alarm_1.hour_is_12h_format),
            hour_data =
              byte_to_bits(data.Alarm_1.hour_data),
            ignore_hour =
              bool_to_bit(data.Alarm_1.ignore_hour),

            minute_bcd =
              byte_to_bits(data.Alarm_1.minute_bcd),
            ignore_minute =
              bool_to_bit(data.Alarm_1.ignore_minute),

            second_bcd =
              byte_to_bits(data.Alarm_1.second_bcd),
            ignore_second =
              bool_to_bit(data.Alarm_1.ignore_second),
          },

        alarm_2 =
          {
            dateday_bcd =
              byte_to_bits(data.Alarm_2.dateday_bcd),
            dateday_is_day =
              bool_to_bit(data.Alarm_2.dateday_is_day),
            ignore_dateday =
              bool_to_bit(data.Alarm_2.ignore_dateday),

            hour_is_12h_format =
              bool_to_bit(data.Alarm_2.hour_is_12h_format),
            hour_data =
              byte_to_bits(data.Alarm_2.hour_data),
            ignore_hour =
              bool_to_bit(data.Alarm_2.ignore_hour),

            minute_bcd =
              byte_to_bits(data.Alarm_2.minute_bcd),
            ignore_minute =
              bool_to_bit(data.Alarm_2.ignore_minute),
          },
      }
  end

--[[
  2026 # #
]]
