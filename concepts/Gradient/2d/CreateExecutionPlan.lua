-- Bintree execution plan for 2-d

-- Last mod.: 2025-04-28

-- Imports:
local IntMid = request('!.number.integer.get_middle')
local SegLen = request('!.number.integer.get_segment_length')

local Divide
Divide =
  function(Left, Top, Width, Height, Result)
    -- print('Divide', Left, Top, Width, Height)

    if (Width <= 2) then
      return
    end

    if (Height <= 2) then
      return
    end

    local Right = Left + Width - 1
    local Bottom = Top + Height - 1

    if (Width >= Height) then
      local MidX = IntMid(Left, Right)

      if (MidX == Left) then
        return
      end

      table.insert(Result, { 'V', MidX, Top, Bottom })

      Divide(Left, Top, SegLen(Left, MidX), Height, Result)
      Divide(MidX, Top, SegLen(MidX, Right), Height, Result)

    else
      local MidY = IntMid(Top, Bottom)

      if (MidY == Top) then
        return
      end

      table.insert(Result, { 'H', MidY, Left, Right })

      Divide(Left, Top, Width, SegLen(Top, MidY), Result)
      Divide(Left, MidY, Width, SegLen(MidY, Bottom), Result)
    end
  end

local CreateBintreePlan2d =
  function(self)
    local Left = 1
    local Right = self.Image.Width

    local Top = 1
    local Bottom = self.Image.Height

    local Width = Right - Left + 1
    local Height = Bottom - Top + 1

    local Result = {}

    Divide(Left, Top, Width, Height, Result)

    return Result
  end

-- Exports:
return CreateBintreePlan2d

--[[
  2025-04-28
]]
