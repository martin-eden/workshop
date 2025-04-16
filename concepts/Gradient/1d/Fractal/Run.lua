-- Wrapper for 1-d fractal gradient generator

-- Last mod.: 2025-04-16

-- Imports:
local GetDistance = request('!.number.integer.get_distance')

--[[
  Fill <.Line> with fractal gradient.

  If <.StartColor> is specified, gradient will start
  from that color. Else it will be set to random color.

  Same for <.EndColor>.
]]
local Run =
  function(self)
    self:Init()

    if (self.LineLength <= 2) then
      return
    end

    local StartIndex = 1
    local EndIndex = self.LineLength

    self.MaxDistance = GetDistance(StartIndex, EndIndex)

    self:Plasm(StartIndex, EndIndex)
  end

-- Exports:
return Run

--[[
  2024-09 # # #
  2024-11 #
  2025-04-04
  2025-04-05
  2025-04-06
  2025-04-16
]]
