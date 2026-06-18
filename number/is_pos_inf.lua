-- Check that number represents positive infinity

--[[
  Author: Martin Eden
  Last mod.: 2026-06-18
]]

local is_pos_inf =
  function(n)
    return (n == 1 / 0)
  end

-- Export:
return is_pos_inf

--[[
  2026-06-18
]]
