-- Write label string to output

-- Last mod.: 2025-03-29

-- Exports:
return
  function(self)
    local FormatLabel = self.Settings:GetFormatLabel()

    self:WriteLine(
      string.format(self.LabelFmt, FormatLabel)
    )
  end

--[[
  2024-11-02
  2024-12-12
  2025-03-28
]]
