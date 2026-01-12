-- Internal function to escape $ in file name

--[[
  Author: Martin Eden
  Last mod.: 2026-01-12
]]

-- Replace "$" to "\$" in string to avoid interpreting this as variable
local EscapeDollar =
  function(s)
    return string.gsub(s, '%$', '\\$')
  end

return EscapeDollar

-- 2026-01-12
