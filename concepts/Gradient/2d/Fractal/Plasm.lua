-- 2-d gradient noise filler

-- Last mod.: 2025-04-16

-- Imports:
local IntMid = request('!.number.integer.get_middle')
local SegLen = request('!.number.integer.get_segment_length')

--[[
  Receives image rectangle description with four corner points set.
  Makes more such rectangles.

      Left
  Top +------------------- Width ------------------+
      |                                            |
      |  *                   *                   * |
      |                                            |
      |                                            |
      |                                            | Height
      |  *                   *                   * |
      |                                            |
      |                                            |
      |                                            |
      |  *                   *                   * |
      +--------------------------------------------+
]]

local Plasm =
  function(self, Left, Top, Width, Height)
    -- print(('(%d %d) %dx%d'):format(Left, Top, Width, Height))

    local Right = Left + Width - 1
    local Bottom = Top + Height - 1

    local MidX = IntMid(Left, Right)
    local MidY = IntMid(Top, Bottom)

    local TopLeft = { X = Left, Y = Top }
    local TopRight = { X = Right, Y = Top }
    local BottomLeft = { X = Left, Y = Bottom }
    local BottomRight = { X = Right, Y = Bottom }

    local IsWide = (Width >= Height)

    if IsWide then
      if (Width <= 2) then
        return
      end

      self:SpawnMidpoint(TopLeft, TopRight)
      self:SpawnMidpoint(BottomLeft, BottomRight)

      self:Plasm(Left, Top, SegLen(Left, MidX), Height)
      self:Plasm(MidX, Top, SegLen(MidX, Right), Height)

    else
      if (Height <= 2) then
        return
      end

      self:SpawnMidpoint(TopLeft, BottomLeft)
      self:SpawnMidpoint(TopRight, BottomRight)

      self:Plasm(Left, Top, Width, SegLen(Top, MidY))
      self:Plasm(Left, MidY, Width, SegLen(MidY, Bottom))
    end
  end

-- Exports:
return Plasm

--[[
  2025-04-04
  2025-04-11
  2024-04-14
  2024-04-16
]]
