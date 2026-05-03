-- String Value methods

--[[
  Author: Martin Eden
  Last mod.: 2026-05-03
]]

--[[
  Data structure

    Value [s]
]]

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
          string.sub(Me.Value, Range:GetStart(), Range:GetStop())
      end,
    Add =
      function(Me, Data, Range)
        Me.Value = Me.Value .. Data:GetRangeValue(Range)
      end,
  }

--[[
  2026-05-02
]]
