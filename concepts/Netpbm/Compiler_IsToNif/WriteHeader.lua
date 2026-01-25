-- Write header to output

--[[
  Author: Martin Eden
  Last mod.: 2026-01-25
]]

-- Exports:
return
  function(self, DataIs)
    local Settings = self.Settings
    local Data
    local Comment

    do
      Data = Settings:GetFormatLabel()
      Comment =
        Settings.Formats[Settings.DataEncoding][Settings.ColorFormat]['Comment']

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

      Comment = 'Width, Height, MaxValue'

      self:WriteLine(Data, Comment)
    end
  end

--[[
  2024-11 # #
  2024-12-12
  2025-03-28
  2025-04-09
]]
