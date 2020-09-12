--[[
  Return whether given integer is valid year.

  If not, return false and string with error message.

  Gregorian calendar assumed.
  Common Era assumed (positive year numbers).
]]

return
  function(year)
    assert_integer(year)
    local result, err_msg
    result = (year >= 1)
    if not result then
      err_msg =
        ('Invalid value for year of Common Era: %d.'):format(year)
    end
    return result, err_msg
  end
