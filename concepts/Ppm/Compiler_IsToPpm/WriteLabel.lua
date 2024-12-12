-- Write label string to output

-- Last mod.: 2024-12-12

-- Exports:
return
  function(self)
    self:WriteLine(
      string.format(self.LabelFmt, self.Constants.FormatLabel)
    )
  end

--[[
  2024-11-02
  2024-12-12
]]
