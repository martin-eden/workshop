--[[
  Check that minute has valid number.
]]

local is_valid_minute = request('!.concepts.daytime.is_valid_minute')

return
  function(data)
    return is_valid_minute(data.moment.minute)
  end
