-- 2-d gradient noise filler

-- Last mod.: 2025-04-14

-- Imports:
local IntMid = request('!.number.integer.get_middle')

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

      local TopMid = { X = MidX, Y = Top }
      local BottomMid = { X = MidX, Y = Bottom }

      self:SpawnPoint(TopMid, TopLeft, TopRight)
      self:SpawnPoint(BottomMid, BottomLeft, BottomRight)

      self:Plasm(Left, Top, MidX - Left + 1, Height)
      self:Plasm(MidX, Top, Right - MidX + 1, Height)

    else
      if (Height <= 2) then
        return
      end

      local MidLeft = { X = Left, Y = MidY }
      local MidRight = { X = Right, Y = MidY }

      self:SpawnPoint(MidLeft, TopLeft, BottomLeft)
      self:SpawnPoint(MidRight, TopRight, BottomRight)

      self:Plasm(Left, Top, Width, MidY - Top + 1)
      self:Plasm(Left, MidY, Width, Bottom - MidY + 1)
    end
  end

-- Exports:
return Plasm

--[[
  2025-04-04
  2025-04-11
  2024-04-14
]]
