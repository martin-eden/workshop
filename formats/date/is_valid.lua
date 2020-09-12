--[[
  Check that date is valid.

  Date is passed as three integer fields "year", "month", "day".
  Gregorian calender assumed.

  In case of invalid date returns
    false,
    string with error
]]

local is_valid_year = request('is_valid_year')
local is_valid_month = request('is_valid_month')
local is_valid_monthday = request('is_valid_monthday')

return
  function(year, month, day)
    local result, err_msg

    result, err_msg = is_valid_year(year)
    if result then
      result, err_msg = is_valid_month(month)
      if result then
        result, err_msg =
          is_valid_monthday(day, month, year)
      end
    end

    return result, err_msg, err_report
  end
