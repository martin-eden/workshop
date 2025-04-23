-- Convert float to integer

-- Last mod.: 2025-04-23

--[[
  Because math.floor() is not suitable for practical case:

    114 / 255 ~= 0.44705882352941
    math.floor(255 * 0.44705882352941) = 113
]]
local ToInt =
  function(n)
    return math.floor(n + 0.5)
  end

-- Exports:
return ToInt

--[[
  2025-04-23
]]
