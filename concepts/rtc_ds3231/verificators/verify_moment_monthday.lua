--[[
  Check that day of month has valid number.

  Decision depends of year (is leap?) and month number.
]]

local is_valid_monthday = request('!.concepts.date.is_valid_monthday')

return
  function(data)
    return
      is_valid_monthday(
        data.moment.date,
        data.moment.month,
        data.moment.year
      )
  end
