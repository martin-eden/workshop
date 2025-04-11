-- 2-d gradient noise recursive filler

-- Last mod.: 2025-04-11

-- Imports:
local IntDistance = request('!.number.integer.get_distance')
local IntMid = request('!.number.integer.get_middle')

local PrintPoint =
  function(self, Point, Name)
    local Name = Name or 'P'

    local Color = self:GetColor(Point)
    if Color then
      Color = ('%.2f'):format(Color[1])
    else
      Color = 'empty'
    end

    print(('%s (%d %d %s)'):format(Name, Point.X, Point.Y, Color))
  end

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
  Receives image rectangle description. And generation mode: square or
  diamond.

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
  function(self)
    while true do
      ::Next::

      if IsEmptyQueue() then
        break
      end

      local Left, Top, Width, Height, Mode, Offset = Dequeue()

      -- print(('(%d %d) %dx%d %s %s'):format(Left, Top, Width, Height, Mode, Offset))

      if (Width <= 2) or (Height <= 2) then
        goto Next
      end

      local Right = Left + Width - 1
      local Bottom = Top + Height - 1

      local MidX = IntMid(Left, Right)
      local MidY = IntMid(Top, Bottom)

      if (Mode == 'square') then
        local LU = { X = Left, Y = Top }
        -- PrintPoint(self, LU, 'Left top')

        local RU = { X = Left + Width - 1, Y = Top }
        -- PrintPoint(self, RU, 'Right top')

        local LB = { X = Left, Y = Top + Height - 1 }
        -- PrintPoint(self, LB, 'Left bottom')

        local RB = { X = Left + Width - 1, Y = Top + Height - 1 }
        -- PrintPoint(self, RB, 'Right bottom')

        local C = { X = MidX, Y = MidY }
        -- PrintPoint(self, C, 'Center')

        self:SpawnPoint(C, LU, RU, LB, RB)
        -- PrintPoint(self, C, 'Center')

        Enqueue(Left, Top - Height // 2, Width, Height, 'diamond', 'up')
        Enqueue(C.X, Top, Width, Height, 'diamond', 'right')
        Enqueue(Left, C.Y, Width, Height, 'diamond', 'down')
        Enqueue(Left - Width // 2, Top, Width, Height, 'diamond', 'left')

      elseif (Mode == 'diamond') then
        local U = { X = MidX, Y = Top }
        U.X = U.X + GetXCorrection(Offset, Width)
        -- PrintPoint(self, U, 'Upper corner')

        local R = { X = Left + Width - 1, Y = MidY }
        R.Y = R.Y + GetYCorrection(Offset, Height)
        -- PrintPoint(self, R, 'Right corner')

        local D = { X = MidX, Y = Top + Height - 1 }
        D.X = D.X + GetXCorrection(Offset, Width)
        -- PrintPoint(self, D, 'Down corner')

        local L = { X = Left, Y = MidY }
        L.Y = L.Y + GetYCorrection(Offset, Height)
        -- PrintPoint(self, L, 'Left corner')

        local C = { X = MidX, Y = MidY }
        C.X = C.X + GetXCorrection(Offset, Width)
        C.Y = C.Y + GetYCorrection(Offset, Height)
        -- PrintPoint(self, C, 'Center')

        self:SpawnPoint(C, U, R, D, L)
        -- PrintPoint(self, C, 'Center')

        local HalfWidth = (Width + 1) // 2
        local HalfHeight = (Height + 1) // 2
        if (Offset == 'up') then
          Enqueue(Left, C.Y, HalfWidth, HalfHeight, 'square', Offset)
        elseif (Offset == 'right') then
          Enqueue(Left, Top, HalfWidth, HalfHeight, 'square', Offset)
        elseif (Offset == 'down') then
          Enqueue(C.X, Top, HalfWidth, HalfHeight, 'square', Offset)
        elseif (Offset == 'left') then
          Enqueue(C.X, C.Y, HalfWidth, HalfHeight, 'square', Offset)
        end
      end
    end
  end

local PlasmWrapper =
  function(self, Left, Top, Width, Height)
    Enqueue(Left, Top, Width, Height, 'square', '')

    Plasm(self)
  end

-- Exports:
return PlasmWrapper

--[[
  2025-04-04
  2025-04-11
]]
