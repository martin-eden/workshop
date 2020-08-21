--[[
  Decode date in MS-DOS FAT format (16 bits).
  Return string with ISO 8601 date.
]]

return
  function(raw_date)
    assert_string(raw_date)
    assert(#raw_date == 2)
    local data = ('< I2'):unpack(raw_date)
    local year = (data >> 9) & ((1 << 7) - 1)
    year = year + 1980
    local month = (data >> 5) & ((1 << 4) - 1)
    local day = data & ((1 << 5) - 1)
    local result = ('%04d-%02d-%02d'):format(year, month, day)
    return result
  end
