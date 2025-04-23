-- 1-D "plasm" gradient generation core

-- Last mod.: 2025-04-23

-- Imports:
local GetIntMid = request('!.number.integer.get_middle')
local GetSegLen = request('!.number.integer.get_segment_length')

--[[
  Generate "1-D plasm": midway linear interpolation
  with distance-dependent noise.

  Pre-state: pixels at segment ends are set
  Post-state: pixels of segment are set
]]
local MidwayFilling =
  function(self, Left, Width)
    if (Width <= 2) then
      return
    end

    local Right = Left + Width - 1

    local Mid = GetIntMid(Left, Right)

    self:CreatePixel(Mid, Left, Right)

    self:Plasm(Left, GetSegLen(Left, Mid))
    self:Plasm(Mid, GetSegLen(Mid, Right))
  end

-- Exports:
return MidwayFilling

--[[
  2024-09 #
  2024-10 #
  2024-11 # # # #
  2025-04-09
  2025-04-16
  2025-04-23
]]
