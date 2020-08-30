--[[
  Set valid hour number.

  Handles two possible hour formats: 12h and 24h.
]]

local generate_hour = request('!.concepts.daytime.generate_hour')
local generate_imperial_hour =
  request('!.concepts.daytime.generate_imperial_hour')

return
  function(data, report)
    local hour
    if data.moment.is_12h_format then
      hour = generate_imperial_hour()
    else
      hour = generate_hour()
    end
    data.moment.hour = hour
  end
