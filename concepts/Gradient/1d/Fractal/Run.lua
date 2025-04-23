-- Wrapper for 1-d fractal gradient generator

-- Last mod.: 2025-04-23

--[[
  Fill <.Line> with fractal gradient.

  If <.StartColor> is specified, gradient will start
  from that color. Else it will be set to random color.

  Same for <.EndColor>.
]]
local Run =
  function(self)
    self:Init()
    self:Plasm(1, self.LineLength)
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
  2025-04-23
]]
