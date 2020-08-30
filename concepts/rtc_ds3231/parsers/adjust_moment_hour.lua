--[[
  If hour is in 12h format, change it to 24h format.

  Removes field "moment.is_pm" in that case.

  Renames field "moment.is_12h_format" to "moment.store_hour_in_12h".
  Meaning of this field is to keep wished storage format for
  compilation.

  Alarm hours are not converted to 24h format and not checked for
  validity. This is because it's common practice to set impossible
  hour number like 24 to disable alarm. It will never trigger and
  set "occurred" flag.
]]

local from_ampm_hour = request('!.concepts.daytime.from_ampm_hour')

return
  function(data)
    if data.moment.is_12h_format then
      data.moment.hour = from_ampm_hour(data.moment.hour, data.moment.is_pm)
      data.moment.is_pm = nil
    end
    data.moment.store_hour_in_12h = data.moment.is_12h_format
    data.moment.is_12h_format = nil
    return data
  end
