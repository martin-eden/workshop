-- Return true if pathname is absolute

--[[
  Author: Martin Eden
  Last mod.: 2026-08-10
]]

-- Imports:
local Syntels = request('Syntels')

local empty = Syntels.empty

local is_absolute =
  function(Pathname)
    return (Pathname[1] == empty)
  end

-- Export:
return is_absolute

--[[
  2026-06-12
]]
