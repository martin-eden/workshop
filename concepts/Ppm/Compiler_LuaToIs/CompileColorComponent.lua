-- Serialize color component integer

-- Last mod.: 2024-11-04

-- Imports:
local NumberInRange = request('!.number.in_range')

-- Exports:
return
  function(self, ColorComponent)
    local MaxColorValue = self.Constants.MaxColorValue
    local FormatStr = self.ColorComponentFmt

    if not is_integer(ColorComponent) then
      return
    end

    if not NumberInRange(ColorComponent, 0, MaxColorValue) then
      return
    end

    return string.format(FormatStr, ColorComponent)
  end

--[[
  2024-11-03
]]
