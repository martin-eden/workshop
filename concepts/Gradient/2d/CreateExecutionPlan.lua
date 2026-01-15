-- Bintree execution plan for 2-d

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

--[[
  Contract

  Function receives corners of screen rectangle.

  Screen rectangle is defined by Left, Top, Width and Height.

  Function asks to create some pixels inside that rectangle
  and then implementation calls same function for smaller rectangle.

  Function result is sequence of pixels to create.
  That chain of actions is based of initial corner pixels.
]]

-- Imports:
local IntMid = request('!.number.integer.get_middle')
local SegLen = request('!.number.integer.get_segment_length')

local Divide
Divide =
  function(Left, Top, Width, Height, AlsoFillLeft, AlsoFillTop, Result)
    --[[
      There is beauty in this quasi-symmetry

      Maybe one day I can express it better.
    ]]

    -- print(Width, Height, Left, Top, AlsoFillLeft, AlsoFillTop)

    local Right = Left + Width - 1
    local Bottom = Top + Height - 1

    if (Width >= Height) then
      if (Width <= 2) then
        return
      end

      local MidX = IntMid(Left, Right)

      -- Create middle pixels at roof and floor
      do
        if AlsoFillTop then
          table.insert(
            Result,
            { { Top, MidX }, { Top, Left }, { Top, Right } }
          )
        end

        table.insert(
          Result,
          { { Bottom, MidX }, { Bottom, Left }, { Bottom, Right } }
        )
      end

      Divide(Left, Top, SegLen(Left, MidX), Height, AlsoFillLeft, AlsoFillTop, Result)
      Divide(MidX, Top, SegLen(MidX, Right), Height, false, AlsoFillTop, Result)
    else
      if (Height <= 2) then
        return
      end

      local MidY = IntMid(Top, Bottom)

      -- Create middle pixels at left and right walls
      do
        if AlsoFillLeft then
          table.insert(
            Result,
            { { MidY, Left }, { Top, Left }, { Bottom, Left } }
          )
        end

        table.insert(
          Result,
          { { MidY, Right }, { Top, Right }, { Bottom, Right } }
        )
      end

      Divide(Left, Top, Width, SegLen(Top, MidY), AlsoFillLeft, AlsoFillTop, Result)
      Divide(Left, MidY, Width, SegLen(MidY, Bottom), AlsoFillLeft, false, Result)
    end
  end

local CreateBintreePlan2d =
  function(self)
    local Left = 1
    local Right = self.ImageWidth

    local Top = 1
    local Bottom = self.ImageHeight

    local Width = Right - Left + 1
    local Height = Bottom - Top + 1

    local Result = {}

    Divide(Left, Top, Width, Height, true, true, Result)

    return Result
  end

-- Exports:
return CreateBintreePlan2d

--[[
  2025-04-28
  2026-01-13
]]
