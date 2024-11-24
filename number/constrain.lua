-- Constrain given number between min and max values

-- Last mod.: 2024-11-24

return
  function(num, min, max)
    if (num < min) then
      return min
    end

    if (num > max) then
      return max
    end

    return num
  end

--[[
  2020-09
]]
