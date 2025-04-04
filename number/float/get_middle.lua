-- Return average of float arguments

-- Last mod.: 2025-04-04

--[[
  Calculate average of given float-numbers

  Accepts sequence of arguments. No type checks.
]]
local FloatMid =
  function(...)
    local NumArgs = select('#', ...)

    local Sum = 0.0

    for Index = 1, NumArgs do
      local Arg = select(Index, ...)
      Sum = Sum + Arg
    end

    return Sum / NumArgs
  end

-- Exports:
return FloatMid

--[[
  2024-11-30
  2025-04-04
]]
