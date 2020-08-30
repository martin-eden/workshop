--[[
  Check that year number is valid.
]]

local is_valid_year = request('!.concepts.date.is_valid_year')

return
  function(data)
    local result, err_msg

    result, err_msg = is_valid_year(data.moment.year)
    if result then
      result =
        (data.moment.year >= 2000) and
        (data.moment.year <= 2199)
      if not result then
        err_msg =
          ('Given year %d must be between 2000 and 2199.'):
          format(data.moment.year)
      end
    end

    return result, err_msg
  end
