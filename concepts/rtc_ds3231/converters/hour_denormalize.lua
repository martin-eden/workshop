--[[
  Prepare hour record for storage in given format.

  Logic:

    result.is_12h_format = hour_rec.store_hour_in_12h
    remove(hour_rec.store_hour_in_12h)
    if hour_rec.is_12h_format
      result.hour, result.is_pm = to_ampm_hour(hour_rec.hour)
]]

local to_ampm_hour = request('!.concepts.daytime.to_ampm_hour')

return
  function(hour_rec)
    hour_rec.is_12h_format = hour_rec.store_hour_in_12h
    hour_rec.store_hour_in_12h = nil
    if hour_rec.is_12h_format then
      hour_rec.hour, hour_rec.is_pm = to_ampm_hour(hour_rec.hour)
    end
  end
