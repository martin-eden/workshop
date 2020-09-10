--[[
  Restore year from two last digits and overflow flag.

  Year is stored as two digits and "is_next_century" flag.
  Change it to Gregorian year number by adding base year 2000,
  honoring flag. It removes flag field after conversion.
]]

return
  function(data)
    data.moment.year = data.moment.year + 2000
    if data.moment.is_next_century then
      data.moment.year = data.moment.year + 100
    end
    data.moment.is_next_century = nil
    return data
  end
