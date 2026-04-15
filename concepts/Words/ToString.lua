-- Represent words as string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-15
]]

--[[
  Return string from given list of words
]]
local ToString =
  function(words)
    return table.concat(words, ' ')
  end

-- Export:
return ToString

--[[
  2026-04-15
]]
