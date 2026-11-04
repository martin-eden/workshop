-- Load bitfields tree

--[[
  Author: Martin Eden
  Last mod.: 2026-11-04
]]

local ds3231_ranges_tree_is =
[[
(                             Moment
  (
                                                    ( 001 56 )
    second_bcd         ( 01 7 )
    minute_bcd         ( 09 7 )
    hour_data          ( 17 6 )
    hour_is_12h_format ( 23 1 )
    day_bcd            ( 25 3 )
    date_bcd           ( 33 6 )
    month_bcd          ( 41 5 )
    is_next_century    ( 48 1 )
    year_bcd           ( 49 8 )
  )
                              Alarm_1
  (
                                                    ( 057 32 )
    second_bcd         ( 01 7 )
    ignore_second      ( 08 1 )

    minute_bcd         ( 09 7 )
    ignore_minute      ( 16 1 )

    hour_data          ( 17 6 )
    hour_is_12h_format ( 23 1 )
    ignore_hour        ( 24 1 )

    dateday_bcd        ( 25 6 )
    dateday_is_day     ( 31 1 )
    ignore_dateday     ( 32 1 )
  )
                              Alarm_2
  (
                                                    ( 089 024 )

    minute_bcd         ( 01 7 )
    ignore_minute      ( 08 1 )

    hour_data          ( 09 6 )
    hour_is_12h_format ( 15 1 )
    ignore_hour        ( 16 1 )

    dateday_bcd        ( 17 6 )
    dateday_is_day     ( 23 1 )
    ignore_dateday     ( 24 1 )
  )
                              Status
  (
                                                    ( 113 40 )
    alarm_1_enabled          ( 01 1 )
    alarm_2_enabled          ( 02 1 )
    output_is_from_alarms    ( 03 1 )
    wave_freq_num            ( 04 2 )
    getting_temperature      ( 06 1 )
    atbattery_enable_wave    ( 07 1 )
    atbattery_clock_disabled ( 08 1 )
    alarm_1_occurred         ( 09 1 )
    alarm_2_occurred         ( 10 1 )
    is_busy                  ( 11 1 )
    32kihz_pin_enabled       ( 12 1 )
    time_is_spoiled          ( 16 1 )
    speed_trim               ( 17 8 )

                Temperature
    (
                                        ( 25 16 )
      int                 ( 01 7 )
      is_neg              ( 08 1 )
      frac                ( 15 2 )
    )
  )
)
]]

local itness_from_str = request('!.convert.itness_from_str')
local ranges_tree_from_itness = request('!.convert.ranges_tree_from_itness')

local get_bitfields =
  function()
    local Bitfields_Is = itness_from_str(ds3231_ranges_tree_is)

    return ranges_tree_from_itness(Bitfields_Is)
  end

-- Export:
return get_bitfields

--[[
  2026-05 # # #
  2026-06-07
  2026-11-04
]]
