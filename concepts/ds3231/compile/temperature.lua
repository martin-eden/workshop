return
  function(temp)
    assert((temp >= -128) and (temp <= 127.75))

    temp = math.modf(temp * 4)
    temp = math.tointeger(temp)
    -- <temp> now is signed integer holding 10-bit value
    local int_part = (temp >> 2) & 0xFF
    local frac_part = (temp & 0x3)

    return int_part, frac_part
  end
