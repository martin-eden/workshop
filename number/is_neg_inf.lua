-- Check that number represents negative infinity

--[[
  Author: Martin Eden
  Last mod.: 2026-08-30
]]

-- Export:
return
  function(n)
    return (n == -1 / 0)
  end

--[[
  2026 #
]]
