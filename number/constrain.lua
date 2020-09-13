--[[
  Constrain given number between min and max values.
]]

return
  function(num, min, max)
    if (num < min) then
      return min
    elseif (num > max) then
      return max
    else
      return num
    end
  end
