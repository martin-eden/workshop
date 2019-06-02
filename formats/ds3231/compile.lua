local to_bcd =
  function(v)
    assert_integer(v)
    assert((v >= 0) and (v <= 99))
    local high_nibble = v // 10
    local low_nibble = v % 10
    return high_nibble << 4 | low_nibble
  end

local compile_hour =
  function(hour, is_12h_format)
    local result
    if is_12h_format then
      local is_pm
      if (hour <= 11) then
        is_pm = false
        if (hour == 0) then
          hour = 12
        end
      else
        is_pm = true
        if (hour ~= 12) then
          hour = hour - 12
        end
      end
      result = (1 << 6) | to_bcd(hour)
      if is_pm then
        result = result | (1 << 5)
      end
    else
      result = to_bcd(hour)
    end
    return result
  end

local compile_temperature =
  function(temp)
    assert((temp >= -128) and (temp <= 127.75))

    temp = math.modf(temp * 4)
    temp = math.tointeger(temp)
    -- <temp> now is signed integer holding 10-bit value
    local int_part = (temp >> 2) & 0xFF
    local frac_part = (temp & 0x3)

    return int_part, frac_part
  end

local to_int8 =
  function(v)
    assert_integer(v)
    local result = ('b'):pack(v)
    result = result:byte()
    return result
  end

return
  function(rec)
    local result =
      {
        [0] = to_bcd(rec.moment.second),
        [1] = to_bcd(rec.moment.minute),
        [2] = compile_hour(rec.moment.hour, rec.moment.is_12h_format),
        [3] = to_bcd(rec.moment.dow),
        [4] = to_bcd(rec.moment.date),
        [5] = to_bcd(rec.moment.month),
        [6] = to_bcd(rec.moment.year % 100),
        [16] = to_int8(rec.aging),
      }

    if rec.is_next_century then
      result[5] = result[5] | (1 << 7)
    end

    result[17], result[18] = compile_temperature(rec.temperature)

    return result
  end
