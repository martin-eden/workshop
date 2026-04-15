-- Represent words as string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-15
]]

--[[
  Return string from internal list of words
]]
local ToString =
  function(self)
    local words = self.Words

    return table.concat(words, ' ')
  end

-- Export:
return ToString

--[[
  2026-04-15
]]
