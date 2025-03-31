-- Return format label string for current settings

-- Last mod.: 2025-03-29

-- Exports:
return
  function(self)
    return self.FormatLabels[self.DataEncoding][self.ColorFormat]
  end

--[[
  2025-03-29
]]
