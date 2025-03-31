-- Serialize color component integer

-- Last mod.: 2025-03-29

-- Imports:
local MaxColorValue = request('^.Settings.Interface').MaxColorValue
local NumberInRange = request('!.number.in_range')

-- Exports:
return
  function(self, ColorComponent)
    if not is_integer(ColorComponent) then
      return
    end

    if not NumberInRange(ColorComponent, 0, MaxColorValue) then
      return
    end

    return string.format(self.ColorComponentFmt, ColorComponent)
  end

--[[
  2024-11-03
  2025-03-28
]]
