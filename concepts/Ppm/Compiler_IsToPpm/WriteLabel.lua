-- Write label string to output

-- Last mod.: 2025-03-28

-- Imports:
local FormatLabel = request('^.Constants.Interface').FormatLabel

-- Exports:
return
  function(self)
    self:WriteLine(
      string.format(self.LabelFmt, FormatLabel)
    )
  end

--[[
  2024-11-02
  2024-12-12
  2025-03-28
]]
