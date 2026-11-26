-- Deserialize bits strings of our tree values

--[[
  Author: Martin Eden
  Last mod.: 2026-11-26
]]

local bool_from_bit = request('!.convert.bool_from_bit')
local byte_from_bits = request('!.convert.byte_from_bits')
local sint8_from_byte = request('!.convert.sint8_from_byte')

return
  function(data)
    return
      {
        Status =
          {
            ['32kihz_pin_enabled'] =
              bool_from_bit(data.status['32kihz_pin_enabled']),
            alarm_1_enabled =
              bool_from_bit(data.status.alarm_1_enabled),
            alarm_1_occurred =
              bool_from_bit(data.status.alarm_1_occurred),
            alarm_2_occurred =
              bool_from_bit(data.status.alarm_2_occurred),
            is_busy =
              bool_from_bit(data.status.is_busy),
            atbattery_clock_disabled =
              bool_from_bit(data.status.atbattery_clock_disabled),
            getting_temperature =
              bool_from_bit(data.status.getting_temperature),
            atbattery_enable_wave =
              bool_from_bit(data.status.atbattery_enable_wave),
            output_is_from_alarms =
              bool_from_bit(data.status.output_is_from_alarms),
            time_is_spoiled =
              bool_from_bit(data.status.time_is_spoiled),
            speed_trim =
              sint8_from_byte(byte_from_bits(data.status.speed_trim)),
            wave_freq_num =
              byte_from_bits(data.status.wave_freq_num),

            Temperature =
              {
                is_neg =
                  bool_from_bit(data.status.temperature.is_neg),
                int =
                  byte_from_bits(data.status.temperature.int),
                frac =
                  byte_from_bits(data.status.temperature.frac),
              },
          },

        Moment =
          {
            is_next_century =
              bool_from_bit(data.moment.is_next_century),
            year_bcd =
              byte_from_bits(data.moment.year_bcd),
            month_bcd =
              byte_from_bits(data.moment.month_bcd),
            date_bcd =
              byte_from_bits(data.moment.date_bcd),
            day_bcd =
              byte_from_bits(data.moment.day_bcd),
            hour_is_12h_format =
              bool_from_bit(data.moment.hour_is_12h_format),
            hour_data =
              byte_from_bits(data.moment.hour_data),
            minute_bcd =
              byte_from_bits(data.moment.minute_bcd),
            second_bcd =
              byte_from_bits(data.moment.second_bcd),
          },

        Alarm_1 =
          {
            dateday_bcd =
              byte_from_bits(data.alarm_1.dateday_bcd),
            dateday_is_day =
              bool_from_bit(data.alarm_1.dateday_is_day),
            ignore_dateday =
              bool_from_bit(data.alarm_1.ignore_dateday),

            hour_is_12h_format =
              bool_from_bit(data.alarm_1.hour_is_12h_format),
            hour_data =
              byte_from_bits(data.alarm_1.hour_data),
            ignore_hour =
              bool_from_bit(data.alarm_1.ignore_hour),

            minute_bcd =
              byte_from_bits(data.alarm_1.minute_bcd),
            ignore_minute =
              bool_from_bit(data.alarm_1.ignore_minute),

            second_bcd =
              byte_from_bits(data.alarm_1.second_bcd),
            ignore_second =
              bool_from_bit(data.alarm_1.ignore_second),
          },

        Alarm_2 =
          {
            dateday_bcd =
              byte_from_bits(data.alarm_2.dateday_bcd),
            dateday_is_day =
              bool_from_bit(data.alarm_2.dateday_is_day),
            ignore_dateday =
              bool_from_bit(data.alarm_2.ignore_dateday),

            hour_is_12h_format =
              bool_from_bit(data.alarm_2.hour_is_12h_format),
            hour_data =
              byte_from_bits(data.alarm_2.hour_data),
            ignore_hour =
              bool_from_bit(data.alarm_2.ignore_hour),

            minute_bcd =
              byte_from_bits(data.alarm_2.minute_bcd),
            ignore_minute =
              bool_from_bit(data.alarm_2.ignore_minute),
          },
      }
  end

--[[
  2026 # #
]]
