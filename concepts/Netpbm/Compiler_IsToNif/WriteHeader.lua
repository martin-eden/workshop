-- Write header to output

-- Last mod.: 2025-04-09

-- Imports:
local FormatDescriptions = request('Internals.FormatDescriptions')

-- Exports:
return
  function(self, DataIs)
    local Settings = self.Settings
    local Data
    local Comment

    do
      Data = Settings:GetFormatLabel()
      Comment =
        FormatDescriptions[Settings.DataEncoding][Settings.ColorFormat]

      self:WriteLine(Data, Comment)
    end

    do
      local Height = #DataIs
      local Width = #DataIs[1]
      local MaxColorValue = Settings.MaxColorValue

      Data =
        tostring(Width) .. ' ' ..
        tostring(Height) .. ' ' ..
        tostring(MaxColorValue)

      Comment = 'Width, Height, 255'

      self:WriteLine(Data, Comment)
    end
  end

--[[
  2024-11 # #
  2024-12-12
  2025-03-28
  2025-04-09
]]
