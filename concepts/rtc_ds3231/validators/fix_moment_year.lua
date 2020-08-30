--[[
  Set valid year number (from 2000 to 2199).
]]

return
  function(data, err_report)
    data.moment.year = math.random(2000, 2199)
  end
