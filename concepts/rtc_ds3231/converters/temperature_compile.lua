--[[
  Compile temperature value to 10-bit integer.

  Value range: -128 .. 127.75
  Granularity: 0.25

  Bits 9..2 contain integer part, 1..0 - fractional part.

  Two's complement encoding for negative values.
]]

return
  function(temp)
    local result

    assert((temp >= -128) and (temp <= 127.75))

    result = math.modf(temp * 4)
    result = math.tointeger(result)

    return result
  end
