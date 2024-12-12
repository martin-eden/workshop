-- Write header to output

-- Last mod.: 2024-12-12

-- Exports
return
  function(self, DataIs)
    local Height = #DataIs
    local Width = #DataIs[1]
    local MaxColorValue = self.Constants.MaxColorValue

    self:WriteLine(
      string.format(
        self.HeaderFmt,
        Width,
        Height,
        MaxColorValue
      )
    )
  end

--[[
  2024-11-03
  2024-12-12
]]
