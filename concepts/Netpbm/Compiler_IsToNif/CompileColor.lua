-- Compile pixel to string

-- Last mod.: 2025-04-09

-- Imports:
local ListToString = request('!.concepts.List.ToString')

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
