-- Map number belonging to one range to number in another range

-- Last mod.: 2024-11-24

-- Imports:
local FitToRange = request('!.number.fit_to_range')

--[[
  Parameters order may look strange here. But consider
  calling it with infix notation: {0.0, 1.0}.MapNumber(64, {0, 255})
]]
local MapNumber =
  function(DestRange, Number, SrcRange)
    --[[
      Typical implementation is usually uses one formula.
      I can understand it and write it that way.
      But I value clarity more than smartassism and some performance.
    ]]

    local SrcRangeLen = SrcRange[2] - SrcRange[1]
    local DestRangeLen = DestRange[2] - DestRange[1]

    Number = FitToRange(Number, SrcRange)

    -- Offset in source range
    Number = Number - SrcRange[1]
    -- Part of source range
    Number = Number / SrcRangeLen
    -- Offset in dest range
    Number = Number * DestRangeLen
    -- Value in dest range
    Number = Number + DestRange[1]

    return Number
  end

-- Exports:
return MapNumber

--[[
  2024-11-24
]]
