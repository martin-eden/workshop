-- Linear 1-d generator

-- Last mod.: 2025-04-28

local t2s = request('!.table.as_string')

--[[
  Generate linear gradient between two points

  If no endline pixels are set, we'll set them to random colors.
]]
local Run =
  function(self)
    self:Init()
    self:Generate()
  end

-- Exports:
return Run

--[[
  2025-04-05
  2025-04-15
  2025-04-23
  2025-04-25
  2025-04-28
]]
