--[[
  Change month to some valid number.
]]

local generate_month = request('!.concepts.date.generate_month')

return
  function(data, report)
    data.moment.month = generate_month()
  end
