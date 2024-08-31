-- Counter class

return
  {
    -- Interface

    -- Initialization setup
    Init =
      function(self, StartValue)
        assert_integer(self.MinValue)
        assert_integer(self.MaxValue)
        assert(self.MinValue <= self.MaxValue)

        if is_nil(StartValue) then
          if is_nil(self.Value) then
            -- Fallback to min value
            self.Value = self.MinValue
          end
        else
          assert_integer(StartValue)
          if
            (StartValue < self.MinValue) or
            (StartValue > self.MaxValue)
          then
            local ErrorMsgFmt =
              '[Counter] Starting value out of range: (%d not in [%d, %d]).'
            local ErrorMsg =
              string.format(
                ErrorMsgFmt,
                StartValue,
                self.MinValue,
                self.MaxValue
              )
            error(ErrorMsg)
          end
          self.Value = StartValue
        end
      end,

    -- Return current value
    Get =
      function(self)
        return self.Value
      end,

    -- Move one unit forward
    Increase =
      function(self)
        if (self.Value >= self.MaxValue) then
          if (self.Value > self.MaxValue) then
            self.Value = self.MaxValue
          end
          return false
        end
        self.Value = self.Value + 1
        return true
      end,

    -- Move one unit backward
    Decrease =
      function(self)
        if (self.Value <= self.MinValue) then
          if (self.Value < self.MinValue) then
            self.Value = self.MinValue
          end
          return false
        end
        self.Value = self.Value - 1
        return true
      end,

    -- Intensities

    -- Current value
    Value = nil,

    -- Range min value
    MinValue = 0,

    -- Range max value
    MaxValue = 100,
  }

--[[
  2024-08-31
]]
