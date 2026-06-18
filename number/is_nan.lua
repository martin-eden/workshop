-- Check that number is "not a number" lol

--[[
  Author: Martin Eden
  Last mod.: 2026-06-18
]]

local is_nan =
  function(n)
    return (n ~= n)
  end

-- Export:
return is_nan

--[[
  2026-06-18
]]
