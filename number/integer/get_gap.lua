-- Return gap between two integers. (Gap between 4 and 5 is 0.)

--[[
  We can generalize this function as

  (Left, Right, UnitWidth)
    return ((Right - Left) - UnitWidth)

  and UnitWidth is 1 for integers and 0 for floats.

  But I just need it for integers.
]]

return
  function(Left, Right)
    return ((Right - Left) - 1)
  end

--[[
  2024-09
]]
