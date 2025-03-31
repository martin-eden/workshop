-- Set format label in settings

-- Last mod.: 2025-03-30

-- Imports:
local GetPathsToValues = request('!.table.get_paths')

--[[
  Set "data encoding" and "color format" fields in settings
  depending of "format label".
]]
local SetFormatLabel =
  function(self, Label)
    local Paths = GetPathsToValues(self.FormatLabels)

    local LabelPath = Paths[Label]

    if not LabelPath then
      -- Unknown format label
      return
    end

    self.ColorFormat = LabelPath[1][2]
    self.DataEncoding = LabelPath[1][1]

    return true
  end

-- Exports:
return SetFormatLabel

--[[
  2025-03-30
]]
