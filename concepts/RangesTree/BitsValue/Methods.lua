-- Bits Value methods

--[[
  Author: Martin Eden
  Last mod.: 2026-05-02
]]

--[[
  Data structure

    Value [i]
]]

-- Imports:
local slice_bits = request('!.number.slice_bits')

-- Export:
return
  {
    GetValue =
      function(Me)
        return Me.Value
      end,
    GetRangeValue =
      function(Me, Range)
        return
          slice_bits(Me.Value, Range:GetStart() - 1, Range:GetStop() - 1)
      end,
    Add =
      function(Me, Data, Range)
        Me.Value =
          (Me.Value << Range:GetLength()) | Data:GetRangeValue(Range)
      end
  }

--[[
  2026-05-02
]]
