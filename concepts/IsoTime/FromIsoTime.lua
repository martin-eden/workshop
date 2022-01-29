local Iso8601TimeFmt = '^(%d%d):(%d%d):(%d%d)$'

return
  function(TimeStr)
    assert_string(TimeStr)
    local Hour, Minute, Second = TimeStr:match(Iso8601TimeFmt)
    if not Hour then
      error(
        ('String %q does not match ISO 8601 time format %q.'):
        format(TimeStr, Iso8601TimeFmt)
      )
    end
    return Hour, Minute, Second
  end

