--[[
  Return whether year is leap.

  Year should be natural number of year in Common Era.
]]

local is_valid_year = request('is_valid_year')

return
  function(year)
    assert(is_valid_year(year))
    return
      ((year % 4 == 0) and (year % 100 ~= 0)) or
      (year % 400 == 0)
  end
