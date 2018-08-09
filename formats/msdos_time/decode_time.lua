--[[
  Decode time given in MS-DOS FAT format (16 bits).
  Return string with ISO 8601 time.
]]

return
  function(raw_time)
    assert_string(raw_time)
    assert(#raw_time == 2)
    local data = ('< I2'):unpack(raw_time)
    local hour = (data >> 11) & ((1 << 5) - 1)
    hour = hour
    local minute = (data >> 5) & ((1 << 6) - 1)
    local second = data & ((1 << 5) - 1)
    second = second * 2
    local result = ('%02d:%02d:%02d'):format(hour, minute, second)
    return result
  end
