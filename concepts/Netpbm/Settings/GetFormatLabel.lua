-- Return format label string for current settings

--[[
  Author: Martin Eden
  Last mod.: 2026-01-25
]]

-- Exports:
return
  function(self)
    return self.Formats[self.DataEncoding][self.ColorFormat]['Signature']
  end

--[[
  2025-03-29
]]
