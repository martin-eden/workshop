--[[
  Check that date is valid.
]]

local is_valid_date = request('!.formats.date.is_valid')

return
  function(data)
    local result, err_msg

    result, err_msg =
      is_valid_date(data.moment.year, data.moment.month, data.moment.date)
    if result then
      result =
        (data.moment.year >= 2000) and
        (data.moment.year <= 2199)
      if not result then
        err_msg =
          ('Given year %d must be between 2000 and 2199'):
          format(data.moment.year)
      end
    end

    return result, err_msg
  end
