--[[
  Return whether given number is day of month.

  Receives three arguments
    day of month
    month number
    year_number

  If number is not day of month, return false and string with details.
]]

local is_valid_month = request('is_valid_month')
local is_valid_year = request('is_valid_year')
local is_leap_year = request('is_leap_year')
local days_in_month = request('days_in_month')

return
  function(day, month, year)
    assert_integer(day)
    assert(is_valid_month)
    assert(is_valid_year)

    local result, err_msg
    result =
      (day >= 1) and (day <= days_in_month[is_leap_year(year)][month])
    if not result then
      err_msg =
        ('Invalid month day %d for date %04d-%02d.'):
        format(day, year, month)
    end

    return result, err_msg
  end
