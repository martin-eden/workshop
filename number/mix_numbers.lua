-- Mix two numbers in given proportion

-- Last mod.: 2024-11-10

--[[
  Example:

    mix(100, 200, 0.8) -> 180
]]
local MixNumbers =
  function(Value_A, Value_B, Part_A)
    return (Value_A * Part_A + Value_B * (1 - Part_A))
  end

-- Exports:
return MixNumbers

--[[
  2024-11-10
]]
