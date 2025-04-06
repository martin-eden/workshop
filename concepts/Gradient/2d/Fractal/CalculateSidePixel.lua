-- Calculate pixel on side of image rectangle

-- Last mod.: 2025-04-05

-- Imports:
local IntMid = request('!.number.integer.get_middle')
local IntDist = request('!.number.integer.get_distance')
local FloatMid = request('!.number.float.get_middle')
local Clamp = request('!.number.constrain')

local PrintCoord =
  function(PointName, Point)
    print(('%s ( %03d %03d )'):format(PointName, Point.X, Point.Y))
  end

--[[
  Calculate pixel's value on middle of one sides of screen rectangle

    ├ ┤ ┬ ┴

  Things are stopping be obvious at this point.

  At core we have "base" side which is horizontal or vertical and
  "apex" point which drops to middle of base.

  We want to calculate color component value for that middle point
  on base side.
]]
local CalculateSidePixel =
  function(self, SideStart, SideEnd, Apex)
    --[[
      Calculations here are okay only for our custom case.
    ]]

    -- PrintCoord('SideStart', SideStart)
    -- PrintCoord('SideEnd', SideEnd)
    -- PrintCoord('Apex', Apex)

    local X = IntMid(SideStart.X, SideEnd.X)
    local Y = IntMid(SideStart.Y, SideEnd.Y)
    local Color = new(self.BaseColor)

    local BaseWeight
    local ApexWeight
    do
      local BaseWidth
      local ApexHeight

      -- If horizontal
      if (SideStart.Y == SideEnd.Y) then
        BaseWidth = IntDist(SideStart.X, SideEnd.X)
        ApexHeight = math.abs(IntDist(SideStart.Y, Apex.Y))
      else
        BaseWidth = IntDist(SideStart.Y, SideEnd.Y)
        ApexHeight = math.abs(IntDist(SideStart.X, Apex.X))
      end

      -- print('BaseWidth', BaseWidth)
      -- print('ApexHeight', ApexHeight)

      if (BaseWidth <= 1) or (ApexHeight == 0) then
        -- print('Early return', self.Image[Y][X][1])
        return
      end

      -- Normalize for (<BaseWeight> + <ApexWeight> == 1)
      local TotalLength = BaseWidth + ApexHeight
      BaseWeight = BaseWidth / TotalLength
      ApexWeight = ApexHeight / TotalLength
    end

    local HalfBaseWeight = BaseWeight / 2

    for Index in ipairs(Color) do
      local BaseStartVal = SideStart.Color[Index]
      local BaseEndVal = SideEnd.Color[Index]
      local ApexVal = Apex.Color[Index]

      local Value =
        (
          BaseStartVal * HalfBaseWeight +
          BaseEndVal * HalfBaseWeight +
          ApexVal * ApexWeight
        )

      Value = Clamp(Value, 0.0, 1.0)

      -- print('HalfBaseWeight', HalfBaseWeight)
      -- print('ApexWeight', ApexWeight)
      -- print('BaseStartVal', BaseStartVal)
      -- print('BaseEndVal', BaseEndVal)
      -- print('ApexVal', ApexVal)
      -- print('Value', Value)

      Color[Index] = Value
    end

    return { X = X, Y = Y, Color = Color }
  end

-- Exports:
return CalculateSidePixel

--[[
  2025-04-04
]]
