-- Constrain number to symmetrical unit interval [-1.0, +1.0]

-- Last mod.: 2025-04-16

-- Imports:
local constrain = request('!.number.constrain')

-- Exports:
return
  function(n)
    return constrain(n, -1.0, 1.0)
  end

--[[
  2025-04-16
]]
