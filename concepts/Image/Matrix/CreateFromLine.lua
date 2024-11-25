-- Create 2-d image by duplicating line

-- Last mod.: 2024-11-25

--[[
  Stack line image N times
]]
local StackLineImage =
  function(NumTimes, LineImage)
    local Result = {}

    for Index = 1, NumTimes do
      Result[Index] = new(LineImage)
    end

    return Result
  end

-- Exports:
return StackLineImage

--[[
  2024-11-25
]]
