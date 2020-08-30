--[[
  Check that hour has valid number.

  Hour can be in 12-hour "imperial" format or usual 24-hour format.
]]

local is_valid_hour = request('!.concepts.daytime.is_valid_hour')
local is_valid_imperial_hour =
  request('!.concepts.daytime.is_valid_imperial_hour')

return
  function(data)
    local hour = data.moment.hour
    if data.moment.is_12h_format then
      return is_valid_imperial_hour(hour)
    else
      return is_valid_hour(hour)
    end
  end
