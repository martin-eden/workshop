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
    local Result = { }

    Result.Status = { }
    Result.Status['32kihz_pin_enabled'] =
      bool_to_bit(DataTree.Status['32kihz_pin_enabled'])
    Result.Status.alarm_1_enabled =
      bool_to_bit(DataTree.Status.alarm_1_enabled)
    Result.Status.alarm_1_occurred =
      bool_to_bit(DataTree.Status.alarm_1_occurred)
    Result.Status.alarm_2_occurred =
      bool_to_bit(DataTree.Status.alarm_2_occurred)
    Result.Status.is_busy =
      bool_to_bit(DataTree.Status.is_busy)
    Result.Status.atbattery_clock_disabled =
      bool_to_bit(DataTree.Status.atbattery_clock_disabled)
    Result.Status.getting_temperature =
      bool_to_bit(DataTree.Status.getting_temperature)
    Result.Status.atbattery_enable_wave =
      bool_to_bit(DataTree.Status.atbattery_enable_wave)
    Result.Status.output_is_from_alarms =
      bool_to_bit(DataTree.Status.output_is_from_alarms)
    Result.Status.time_is_spoiled =
      bool_to_bit(DataTree.Status.time_is_spoiled)
    Result.Status.speed_trim =
      byte_to_bits(sint8_to_byte(DataTree.Status.speed_trim))
    Result.Status.wave_freq_num =
      byte_to_bits(DataTree.Status.wave_freq_num)

    Result.Status.Temperature = { }

    Result.Status.Temperature.is_neg =
      bool_to_bit(DataTree.Status.Temperature.is_neg)
    Result.Status.Temperature.int =
      byte_to_bits(DataTree.Status.Temperature.int)
    Result.Status.Temperature.frac =
      byte_to_bits(DataTree.Status.Temperature.frac)

    Result.Moment = { }

    Result.Moment.is_next_century =
      bool_to_bit(DataTree.Moment.is_next_century)
    Result.Moment.year_bcd =
      byte_to_bits(DataTree.Moment.year_bcd)
    Result.Moment.month_bcd =
      byte_to_bits(DataTree.Moment.month_bcd)
    Result.Moment.date_bcd =
      byte_to_bits(DataTree.Moment.date_bcd)
    Result.Moment.day_bcd =
      byte_to_bits(DataTree.Moment.day_bcd)
    Result.Moment.minute_bcd =
      byte_to_bits(DataTree.Moment.minute_bcd)
    Result.Moment.second_bcd =
      byte_to_bits(DataTree.Moment.second_bcd)

    Result.Moment.Hour = { }

    Result.Moment.Hour.is_12h_format =
      bool_to_bit(DataTree.Moment.Hour.is_12h_format)
    Result.Moment.Hour['12h_format_is_pm'] =
      bool_to_bit(DataTree.Moment.Hour['12h_format_is_pm'])
    Result.Moment.Hour['12h_format_hour_bcd'] =
      byte_to_bits(DataTree.Moment.Hour['12h_format_hour_bcd'])
    Result.Moment.Hour['24h_format_hour_bcd'] =
      byte_to_bits(DataTree.Moment.Hour['24h_format_hour_bcd'])

    Result.Alarm_1 = { }

    Result.Alarm_1.DateDay = { }

    Result.Alarm_1.DateDay.is_day =
      bool_to_bit(DataTree.Alarm_1.DateDay.is_day)
    Result.Alarm_1.DateDay.dateday_bcd =
      byte_to_bits(DataTree.Alarm_1.DateDay.dateday_bcd)
    Result.Alarm_1.DateDay.ignore =
      bool_to_bit(DataTree.Alarm_1.DateDay.ignore)

    Result.Alarm_1.Hour = { }

    Result.Alarm_1.Hour.is_12h_format =
      bool_to_bit(DataTree.Alarm_1.Hour.is_12h_format)
    Result.Alarm_1.Hour['12h_format_is_pm'] =
      bool_to_bit(DataTree.Alarm_1.Hour['12h_format_is_pm'])
    Result.Alarm_1.Hour['12h_format_hour_bcd'] =
      byte_to_bits(DataTree.Alarm_1.Hour['12h_format_hour_bcd'])
    Result.Alarm_1.Hour['24h_format_hour_bcd'] =
      byte_to_bits(DataTree.Alarm_1.Hour['24h_format_hour_bcd'])
    Result.Alarm_1.Hour.ignore =
      bool_to_bit(DataTree.Alarm_1.Hour.ignore)

    Result.Alarm_1.Minute = { }

    Result.Alarm_1.Minute.minute_bcd =
      byte_to_bits(DataTree.Alarm_1.Minute.minute_bcd)
    Result.Alarm_1.Minute.ignore =
      bool_to_bit(DataTree.Alarm_1.Minute.ignore)

    Result.Alarm_1.Second = { }

    Result.Alarm_1.Second.second_bcd =
      byte_to_bits(DataTree.Alarm_1.Second.second_bcd)
    Result.Alarm_1.Second.ignore =
      bool_to_bit(DataTree.Alarm_1.Second.ignore)

    Result.Alarm_2 = { }

    Result.Alarm_2.DateDay = { }

    Result.Alarm_2.DateDay.is_day =
      bool_to_bit(DataTree.Alarm_2.DateDay.is_day)
    Result.Alarm_2.DateDay.dateday_bcd =
      byte_to_bits(DataTree.Alarm_2.DateDay.dateday_bcd)
    Result.Alarm_2.DateDay.ignore =
      bool_to_bit(DataTree.Alarm_2.DateDay.ignore)

    Result.Alarm_2.Hour = { }

    Result.Alarm_2.Hour.is_12h_format =
      bool_to_bit(DataTree.Alarm_2.Hour.is_12h_format)
    Result.Alarm_2.Hour['12h_format_is_pm'] =
      bool_to_bit(DataTree.Alarm_2.Hour['12h_format_is_pm'])
    Result.Alarm_2.Hour['12h_format_hour_bcd'] =
      byte_to_bits(DataTree.Alarm_2.Hour['12h_format_hour_bcd'])
    Result.Alarm_2.Hour['24h_format_hour_bcd'] =
      byte_to_bits(DataTree.Alarm_2.Hour['24h_format_hour_bcd'])
    Result.Alarm_2.Hour.ignore =
      bool_to_bit(DataTree.Alarm_2.Hour.ignore)

    Result.Alarm_2.Minute = { }

    Result.Alarm_2.Minute.minute_bcd =
      byte_to_bits(DataTree.Alarm_2.Minute.minute_bcd)
    Result.Alarm_2.Minute.ignore =
      bool_to_bit(DataTree.Alarm_2.Minute.ignore)

    return Result
  end

-- Export:
return tree_values_to_bits

--[[
  2026-05-07
]]
