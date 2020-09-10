--[[
  Prepare hour record for storage in given format.

  Logic:

    if hour_rec.store_hour_in_12h
      result.hour, result.is_pm = to_ampm_hour(hour_rec.hour)
    result.is_12h_format = hour_rec.store_hour_in_12h
]]

local to_ampm_hour = request('!.concepts.daytime.to_ampm_hour')

return
  function(hour_rec)
    if hour_rec.store_hour_in_12h then
      hour_rec.hour, hour_rec.is_pm = to_ampm_hour(hour_rec.hour)
    end
    hour_rec.store_hour_in_12h = nil
  end
