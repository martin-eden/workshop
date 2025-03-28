-- Write header to output

-- Last mod.: 2025-03-28

-- Imports:
local MaxColorValue = request('^.Constants.Interface').MaxColorValue

-- Exports
return
  function(self, DataIs)
    local Height = #DataIs
    local Width = #DataIs[1]

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
  2025-03-28
]]
