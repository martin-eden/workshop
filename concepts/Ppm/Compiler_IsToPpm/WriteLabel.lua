-- Write label string to output

-- Last mod.: 2024-11-02

-- Exports:
return
  function(self, Label)
    self:WriteLine(
      string.format(self.LabelFmt, Label)
    )
  end

--[[
  2024-11-02
]]
