--[[
  Change hour record to 24h format.

  This function renames field "is_12h_format" to "store_hour_in_12h".
  For 12h format it also removes field "is_pm".

  24h hour record is 6-bit BCD so it can store values up to 29.
  12h hour record is 5-bit BCD plus AM/PM flag. So it can store
  values like 19AM or 0PM.

  We do not verify values here. It's other units job.

  Reason for field renaming is to reflect semantic change. Before it
  was signature for custom data format. Now format is unified and it
  is a flag to use custom data format at compilation.
]]

local from_ampm_hour = request('!.concepts.daytime.from_ampm_hour')

return
  function(hour_rec)
    if hour_rec.is_12h_format then
      hour_rec.hour = from_ampm_hour(hour_rec.hour, hour_rec.is_pm)
      hour_rec.is_pm = nil
    end
    hour_rec.store_hour_in_12h = hour_rec.is_12h_format
    hour_rec.is_12h_format = nil
  end
