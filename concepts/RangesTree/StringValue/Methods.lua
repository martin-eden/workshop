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
    Set =
      function(Me, Data, DataRange)
        --[[
          If range is out of our string, we will extend string with
          dummy char.
        ]]
        local dummy_char = '-'
        local value_len = string.len(Me.Value)
        local range_end_pos = DataRange:GetStop()
        if (value_len < range_end_pos) then
          local delta_len = range_end_pos - value_len
          local dummy_str = string.rep(dummy_char, delta_len)
          Me.Value = Me.Value .. dummy_str
        end
        Me.Value =
          string.sub(Me.Value, 1, DataRange:GetStart() - 1) ..
          string.sub(Data:GetValue(), 1, DataRange:GetLength()) ..
          string.sub(Me.Value, DataRange:GetStop() + 1, value_len)
      end,
  }

--[[
  2026-05-02
  2026-05-07
]]
