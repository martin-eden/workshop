-- Return true if pathname is absolute

--[[
  Author: Martin Eden
  Last mod.: 2026-06-12
]]

-- Imports:
local empty = ''

local is_absolute =
  function(Pathname)
    assert_table(Pathname)

    return (Pathname[1] == empty)
  end

-- Export:
return is_absolute

--[[
  2026-06-12
]]
