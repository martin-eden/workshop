-- Return list of words from string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-15
]]

--[[
  Return list of words from given string
]]
local FromString =
  function(str)
    local words = {}

    -- "%S+" - capture non-space sequences
    for word in str:gmatch('%S+') do
      table.insert(words, word)
    end

    return words
  end

-- Export:
return FromString

--[[
  2026-04-15
]]
