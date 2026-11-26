-- Load bitfields tree

--[[
  Author: Martin Eden
  Last mod.: 2026-11-26
]]

local ds3231_ranges_tree_is =
[[
(
  (
    moment
    001
    (
      ( second_bcd 01 7 )
      ( minute_bcd 09 7 )
      ( hour_data 17 6 )
      ( hour_is_12h_format 23 1 )
      ( day_bcd 25 3 )
      ( date_bcd 33 6 )
      ( month_bcd 41 5 )
      ( is_next_century 48 1 )
      ( year_bcd 49 8 )
    )
  )
  (
    alarm_1
    057
    (
      ( second_bcd 01 7 )
      ( ignore_second 08 1 )
      ( minute_bcd 09 7 )
      ( ignore_minute 16 1 )
      ( hour_data 17 6 )
      ( hour_is_12h_format 23 1 )
      ( ignore_hour 24 1 )
      ( dateday_bcd 25 6 )
      ( dateday_is_day 31 1 )
      ( ignore_dateday 32 1 )
    )
  )
  (
    alarm_2
    089
    (
      ( minute_bcd 01 7 )
      ( ignore_minute 08 1 )
      ( hour_data 09 6 )
      ( hour_is_12h_format 15 1 )
      ( ignore_hour 16 1 )
      ( dateday_bcd 17 6 )
      ( dateday_is_day 23 1 )
      ( ignore_dateday 24 1 )
    )
  )
  (
    status
    113
    (
      ( alarm_1_enabled 01 1 )
      ( alarm_2_enabled 02 1 )
      ( output_is_from_alarms 03 1 )
      ( wave_freq_num 04 2 )
      ( getting_temperature 06 1 )
      ( atbattery_enable_wave 07 1 )
      ( atbattery_clock_disabled 08 1 )
      ( alarm_1_occurred 09 1 )
      ( alarm_2_occurred 10 1 )
      ( is_busy 11 1 )
      ( 32kihz_pin_enabled 12 1 )
      ( time_is_spoiled 16 1 )
      ( speed_trim 17 8 )
      (
        temperature
        25
        (
          ( int 01 7 )
          ( is_neg 08 1 )
          ( frac 15 2 )
        )
      )
    )
  )
)
]]

local itness_from_str = request('!.convert.itness_from_str')
local ranges_tree_from_itness =
  request('!.convert.ranges_tree_from_itness')

-- Export:
return
  function()
    local bitfields_is = itness_from_str(ds3231_ranges_tree_is)
    return ranges_tree_from_itness(bitfields_is)
  end

--[[
  2026 # # # # #
  2026-11-26
]]
