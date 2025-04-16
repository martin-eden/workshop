-- Create 2-d image by duplicating line

-- Last mod.: 2025-04-16

--[[
  Stack line image N times
]]
local StackLineImage =
  function(ImageLine, NumTimes)
    local Result = {}

    for Index = 1, NumTimes do
      Result[Index] = new(ImageLine)
    end

    Result.Width = #ImageLine
    Result.Height = NumTimes

    return Result
  end

-- Exports:
return StackLineImage

--[[
  2024-11-25
  2025-04-06
  2025-04-16
]]
