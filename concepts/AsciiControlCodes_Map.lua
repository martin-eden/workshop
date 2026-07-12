-- Return map of ASCII control codes

--[[
  Author: Martin Eden
  Last mod.: 2026-07-12
]]

local ControlCodes_Map = { }

for code = 0, 31 do
  ControlCodes_Map[code] = true
end
ControlCodes_Map[127] = true

-- Export:
return ControlCodes_Map

--[[
  2026-07-12
]]
