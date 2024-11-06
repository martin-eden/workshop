-- Write header to output

-- Last mod.: 2024-11-03

-- Exports
return
  function(self, HeaderIs)
    self:WriteLine(
      string.format(
        self.HeaderFmt,
        HeaderIs[1],
        HeaderIs[2],
        HeaderIs[3]
      )
    )
  end

--[[
  2024-11-03
]]
