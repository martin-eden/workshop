local Iso8601DateFmt = '^(%d%d%d%d)-(%d%d)-(%d%d)$'

return
  function(DateStr)
    assert_string(DateStr)
    local Year, Month, Day = DateStr:match(Iso8601DateFmt)
    if not Year then
      error(
        ('String %q does not match ISO 8601 date format %q.'):
        format(DateStr, Iso8601DateFmt)
      )
    end
    return Year, Month, Day
  end

