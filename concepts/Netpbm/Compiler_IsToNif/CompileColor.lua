-- Compile pixel to string

-- Last mod.: 2026-04-17

-- Imports:
local ListToString = request('!.concepts.list.to_string')

-- Exports:
return
  function(self, ColorIs)
    return ListToString(ColorIs, ' ')
  end

--[[
  2024-11-03
  2025-03-28
  2025-04-09
]]
