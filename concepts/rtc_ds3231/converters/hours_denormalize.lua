--[[
  Prepare hour records for storage in given format.
]]

local denormalize_hour = request('hour_denormalize')

return
  function(data)
    denormalize_hour(data.moment)
    denormalize_hour(data.alarm_1)
    denormalize_hour(data.alarm_2)
    return data
  end
