-- Represent words as string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-17
]]

--[[
  Return string from given list of words
]]
local to_string =
  function(words)
    return table.concat(words, ' ')
  end

-- Export:
return to_string

--[[
  2026-04-15
]]
