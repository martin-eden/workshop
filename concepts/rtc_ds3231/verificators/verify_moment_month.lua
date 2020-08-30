--[[
  Check that month has valid number.
]]

local is_valid_month = request('!.concepts.date.is_valid_month')

return
  function(data)
    return is_valid_month(data.moment.month)
  end
