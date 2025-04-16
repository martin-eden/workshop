-- Caller for 2-d "plasm" generator

-- Last mod.: 2025-04-16

-- Imports:
local IntMid = request('!.number.integer.get_middle')

-- Exports:
return
  function(self)
    self:Init()

    -- Calculate <.MaxDistance>
    do
      --[[
        First, <.CalcDistance> uses <.MaxDistance>.

        Second, although theoretical maximum distance is
        between points in opposite corners, practical maximum distance
        is between corner and midpoint.

          IntMid() returns nearest middle so longest practical distance
          is between middle and bottom right.
      ]]
      self.MaxDistance = 1.0

      local Mid =
        {
          X = IntMid(1, self.ImageWidth),
          Y = IntMid(1, self.ImageHeight),
        }

      local BottomRight =
        {
          X = self.ImageWidth,
          Y = self.ImageHeight,
        }

      self.MaxDistance = self:CalcDistance(Mid, BottomRight)
    end

    self:Plasm(1, 1, self.ImageWidth, self.ImageHeight)
  end

--[[
  2025-04-04
  2025-04-11
]]
