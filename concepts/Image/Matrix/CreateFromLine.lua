-- Create 2-d image by duplicating line

-- Last mod.: 2024-11-25

local BaseMatrix = request('Interface')

--[[
  Stack line image N times
]]
local StackLineImage =
  function(NumTimes, LineImage)
    local Result = new(BaseMatrix)

    for Index = 1, NumTimes do
      Result.Lines[Index] = new(LineImage)
    end

    Result.NumLines = NumTimes

    return Result
  end

-- Exports:
return StackLineImage

--[[
  2024-11-25
]]
