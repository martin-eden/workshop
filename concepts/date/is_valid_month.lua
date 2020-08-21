--[[
  Return whether given integer is valid month number.

  If not, return false and string with error.
]]

return
  function(month)
    assert_integer(month)
    local result, err_msg
    result = (month >= 1) and (month <= 12)
    if not result then
      err_msg =
        ('Invalid value for month number: %d.'):format(month)
    end
    return result, err_msg
  end
