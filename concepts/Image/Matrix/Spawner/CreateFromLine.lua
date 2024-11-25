-- Create 2-d image by duplicating line

-- Last mod.: 2024-11-25

local CreateImage = request('Create')

--[[
  Stack line image N times
]]
local StackLineImage =
  function(NumTimes, LineImage)
    local Result = CreateImage()

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
