--[[
  Store year as last two digits and "is_next_century" flag.
]]

return
  function(data)
    data.moment.year = data.moment.year - 2000
    data.moment.is_next_century = (data.moment.year >= 100)
    if data.moment.is_next_century then
      data.moment.year = data.moment.year - 100
    end
    return data
  end
