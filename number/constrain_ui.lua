-- Constrain number to unit interval [0.0, 1.0]

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local constrain = request('constrain')

return
  function(num)
    return constrain(num, 0.0, 1.0)
  end

--[[
  2025 #
]]
