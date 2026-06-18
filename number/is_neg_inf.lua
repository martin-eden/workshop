-- Check that number represents negative infinity

--[[
  Author: Martin Eden
  Last mod.: 2026-06-18
]]

local is_neg_inf =
  function(n)
    return (n == -1 / 0)
  end

-- Export:
return is_neg_inf

--[[
  2026-06-18
]]
