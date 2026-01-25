-- Set format label in settings

--[[
  Author: Martin Eden
  Last mod.: 2026-01-25
]]

-- Imports:
local GetPathsToValues = request('!.table.get_paths')

--[[
  Set "data encoding" and "color format" fields in settings
  depending of "format label".
]]
local SetFormatLabel =
  function(self, Label)
    local Paths = GetPathsToValues(self.Formats)

    local LabelPath = Paths[Label]

    if not LabelPath then
      -- Unknown format label
      return
    end

    self.DataEncoding = LabelPath[1][1]
    self.ColorFormat = LabelPath[1][2]

    return true
  end

-- Exports:
return SetFormatLabel

--[[
  2025-03-30
]]
