--[[
  Return possible month day number for given month and year.

  We need month because number of days depend of month number and
  we need year because leap year Februaries have 29 days.

  (Technically we just need <is_leap_year> flag but practically
  it's just easier to pass year.)
]]

local is_valid_month = request('is_valid_month')
local is_valid_year = request('is_valid_year')
local is_leap_year = request('is_leap_year')
local days_in_month = request('days_in_month')

return
  function(month, year)
    assert(is_valid_month(month))
    assert(is_valid_year(year))
    return math.random(1, days_in_month[is_leap_year(year)][month])
  end
