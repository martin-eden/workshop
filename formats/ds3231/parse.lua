local assert_byte = request('!.number.assert_byte')

local from_bcd =
  function(v)
    local tenths = v >> 4
    local ones = v & 0xF
    return 10 * tenths + ones
  end

local parse_hour =
  function(v)
    local result
    local is_12h_format = (v & 1 << 6) ~= 0
    if is_12h_format then
      result = from_bcd(v & 0xF)
      local is_pm = (v & 1 << 5) ~= 0
      if is_pm then
        -- 12 p.m. is 12th hour
        if (result ~= 12) then
          result = result + 12
        end
      else
        -- 12 a.m. is zero hour
        if (result == 12) then
          result = 0
        end
      end
    else
      result = from_bcd(v)
    end
    return result, is_12h_format
  end

--[[
  Temperature encoded in two's complement format.
  Temperature is 10-bit value, <frac_part> two high bits is
  two bits of fractional part.
]]
local parse_temperature =
  function(int_part, frac_part)
    local result

    result = (int_part << 2) | (frac_part >> 6)

    -- is negative value?
    if (result & 0x200 ~= 0) then
      result = -(((result & 0x1FF) ~ 0x1FF) + 1)
    end

    result = result / 4

    return result
  end

local from_int8 =
  function(v)
    assert_byte(v)
    v = string.char(v)
    local result = ('b'):unpack(v)
    return result
  end

local base_century = 20

return
  function(dump)
    assert_table(dump)
    local hour, is_12h_format = parse_hour(dump[2])
    local result =
      {
        second = from_bcd(dump[0]),
        minute = from_bcd(dump[1]),
        hour = hour,
        is_12h_format = is_12h_format,
        dow = from_bcd(dump[3]),
        date = from_bcd(dump[4]),
        month = from_bcd(dump[5] & 0x7F),
        is_next_century = (dump[5] & 0x80 ~= 0),
        year = 100 * base_century + from_bcd(dump[6]),
        aging = from_int8(dump[16]),
        temperature = parse_temperature(dump[17], dump[18]),
        --[[ Sketch structure for future additions:
        battery =
          {
            clock_enabled
            custom_wave_output_allowed
          }
        alarm =
          {
            {
              enabled
              second
              minute
              hour
              is_12h_format
              is_date_not_day
              date_day
              ignore_date_day
              ignore_hour
              ignore_minute
              ignore_second
            }
            {
              enabled
              minute
              hour
              is_12h_format
              is_date_not_day
              date_day
              ignore_date_day
              ignore_hour
              ignore_minute
            }
          }
        clock_enabled
        clock_was_stopped
        fixed_wave_32k_enabled
        output_alarms_not_custom_wave
        custom_wave_freq
        converting_temperature
        is_busy
        --]]
      }
    if result.is_next_century then
      result.year = result.year + 100
    end

    return result
  end
