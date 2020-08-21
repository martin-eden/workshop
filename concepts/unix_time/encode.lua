--[[
  Encode timestamp in Unix format (number of seconds since epoch).
  Input is string with timestamp in ISO 8601 format.

  This implementation will work only on *nix machines!
]]

local iso8601_fmt = '(%d%d%d%d)-(%d%d)-(%d%d) (%d%d):(%d%d):(%d%d)'

return
  function(dt_str)
    assert_string(dt_str)
    local year, month, day, hour, min, sec = dt_str:match(iso8601_fmt)
    if not year then
      local msg =
        (
          'Given string does not match ISO 8601 date-time format:' ..
          ' (data: %q; format: %q)'
        ):format(dt_str, iso8601_fmt)
      error(msg)
    end
    local dt_rec =
      {
        year = year,
        month = month,
        day = day,
        hour = hour,
        min = min,
        sec = sec,
      }
    return os.time(dt_rec)
  end
