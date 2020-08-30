--[[
  Check that second has valid number.
]]

local is_valid_second = request('!.concepts.daytime.is_valid_second')

return
  function(data)
    return is_valid_second(data.moment.second)
  end
