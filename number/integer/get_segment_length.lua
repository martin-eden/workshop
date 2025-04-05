-- Return length of segment described by two integers

-- Last mod.: 2025-04-05

--[[
  Return integer segment length

  If given integers does not describe valid segment, return nil.
]]
local GetIntSegLen =
  function(Left, Right)
    if (Left > Right) then
      return
    end

    return (Right - Left + 1)
  end

-- Exports:
return GetIntSegLen

--[[
  2025-04-05
]]
