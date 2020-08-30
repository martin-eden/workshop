--[[
  Change minute to some valid number.
]]

local generate_minute = request('!.concepts.daytime.generate_minute')

return
  function(data, report)
    data.moment.minute = generate_minute()
  end
