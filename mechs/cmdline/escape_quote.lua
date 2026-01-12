-- Internal function to escape " in file name

--[[
  Author: Martin Eden
  Last mod.: 2026-01-12
]]

-- Replace ["] to [\"] in string to avoid breaking quote
local EscapeQuote =
  function(s)
    return string.gsub(s, '"', '\\"')
  end

return EscapeQuote

-- 2026-01-12
