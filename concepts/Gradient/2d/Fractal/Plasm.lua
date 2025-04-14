-- 2-d gradient noise filler

-- Last mod.: 2025-04-12

-- Imports:
local IntDistance = request('!.number.integer.get_distance')
local IntMid = request('!.number.integer.get_middle')

local Queue = {}

local Enqueue =
  function(...)
    local Record = table.pack(...)
    table.insert(Queue, Record)
  end

local Dequeue =
  function()
    local Record = Queue[1]
    table.remove(Queue, 1)
    return table.unpack(Record)
  end

local IsEmptyQueue =
  function()
    return (#Queue == 0)
  end

local GetXCorrection =
  function(Offset, Width)
    if
      ((Offset == 'right') or (Offset == 'left')) and
      (Width % 2 == 0)
    then
      return 1
    end

    return 0
  end

local GetYCorrection =
  function(Offset, Height)
    if
      ((Offset == 'up') or (Offset == 'down')) and
      (Height % 2 == 0)
    then
      return 1
    end

    return 0
  end

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

      self:SpawnPoint(TopMid, TopLeft, TopRight, BottomLeft, BottomRight)

      local BottomMid = { X = MidX, Y = Bottom }

      self:SpawnPoint(BottomMid, TopLeft, TopRight, BottomLeft, BottomRight)

      self:Plasm(Left, Top, MidX - Left + 1, Height)
      self:Plasm(MidX, Top, Right - MidX + 1, Height)

    else
      if (Height <= 2) then
        return
      end

      local MidLeft = { X = Left, Y = MidY }

      self:SpawnPoint(MidLeft, TopLeft, TopRight, BottomLeft, BottomRight)

      local MidRight = { X = Right, Y = MidY }

      self:SpawnPoint(MidRight, TopLeft, TopRight, BottomLeft, BottomRight)

      self:Plasm(Left, Top, Width, MidY - Top + 1)
      self:Plasm(Left, MidY, Width, Bottom - MidY + 1)
    end
  end

-- Exports:
return Plasm

--[[
  2025-04-04
  2025-04-11
]]
