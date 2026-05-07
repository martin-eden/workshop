-- String Value methods

--[[
  Author: Martin Eden
  Last mod.: 2026-05-07
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
      function(Me, Data, DataRange)
        Me.Value = Me.Value .. Data:GetRangeValue(DataRange)
      end,
  }

--[[
  2026-05-02
]]
